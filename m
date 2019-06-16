Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF8104738D
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2019 09:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfFPHMJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jun 2019 03:12:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfFPHMJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jun 2019 03:12:09 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42C67216C8;
        Sun, 16 Jun 2019 07:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560669128;
        bh=YaXvzbrJb2MW/D9EmOptLHN028VlAypqNsKcvcj9HiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xv1AsSfIvwmm1hFnfbpdy0ZbONW2LwTvSEMgFEP+QWWpnxBChCU5wXnDuLeJNH1c1
         yZU/K1Nl4tF0Qgw1CGounBLRTVCMGJ6NyMoXB7/8knkfypN40gmQfvSEEUle/s8WYw
         aZBx4zm1DRZmOqS6Rdp9dtnr3jFzCjk0k0LJpBBo=
Date:   Sun, 16 Jun 2019 00:12:06 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-wireless@vger.kernel.org, kvalo@codeaurora.org,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH] wireless: airo: switch to skcipher interface
Message-ID: <20190616071206.GB698@sol.localdomain>
References: <20190614093603.22771-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614093603.22771-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 14, 2019 at 11:36:03AM +0200, Ard Biesheuvel wrote:
> The AIRO driver applies a ctr(aes) on a buffer of considerable size
> (2400 bytes), and instead of invoking the crypto API to handle this
> in its entirety, it open codes the counter manipulation and invokes
> the AES block cipher directly.
> 
> Let's fix this, by switching to the sync skcipher API instead.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> NOTE: build tested only, since I don't have the hardware
> 
>  drivers/net/wireless/cisco/airo.c | 57 ++++++++++----------
>  1 file changed, 27 insertions(+), 30 deletions(-)
> 

Need to also select CRYPTO_CTR in drivers/net/wireless/cisco/Kconfig under
AIRO_CS, and I think also CRYPTO_BLKCIPHER under AIRO.

> diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
> index 3f5a14112c6b..2d29ad10505b 100644
> --- a/drivers/net/wireless/cisco/airo.c
> +++ b/drivers/net/wireless/cisco/airo.c
> @@ -49,6 +49,9 @@
>  #include <linux/kthread.h>
>  #include <linux/freezer.h>
>  
> +#include <crypto/aes.h>
> +#include <crypto/skcipher.h>
> +
>  #include <net/cfg80211.h>
>  #include <net/iw_handler.h>
>  
> @@ -951,7 +954,7 @@ typedef struct {
>  } mic_statistics;
>  
>  typedef struct {
> -	u32 coeff[((EMMH32_MSGLEN_MAX)+3)>>2];
> +	__be32 coeff[((EMMH32_MSGLEN_MAX)+3)>>2];
>  	u64 accum;	// accumulated mic, reduced to u32 in final()
>  	int position;	// current position (byte offset) in message
>  	union {
> @@ -1216,7 +1219,7 @@ struct airo_info {
>  	struct iw_spy_data	spy_data;
>  	struct iw_public_data	wireless_data;
>  	/* MIC stuff */
> -	struct crypto_cipher	*tfm;
> +	struct crypto_sync_skcipher	*tfm;
>  	mic_module		mod[2];
>  	mic_statistics		micstats;
>  	HostRxDesc rxfids[MPI_MAX_FIDS]; // rx/tx/config MPI350 descriptors
> @@ -1291,14 +1294,14 @@ static int flashrestart(struct airo_info *ai,struct net_device *dev);
>  static int RxSeqValid (struct airo_info *ai,miccntx *context,int mcast,u32 micSeq);
>  static void MoveWindow(miccntx *context, u32 micSeq);
>  static void emmh32_setseed(emmh32_context *context, u8 *pkey, int keylen,
> -			   struct crypto_cipher *tfm);
> +			   struct crypto_sync_skcipher *tfm);
>  static void emmh32_init(emmh32_context *context);
>  static void emmh32_update(emmh32_context *context, u8 *pOctets, int len);
>  static void emmh32_final(emmh32_context *context, u8 digest[4]);
>  static int flashpchar(struct airo_info *ai,int byte,int dwelltime);
>  
>  static void age_mic_context(miccntx *cur, miccntx *old, u8 *key, int key_len,
> -			    struct crypto_cipher *tfm)
> +			    struct crypto_sync_skcipher *tfm)
>  {
>  	/* If the current MIC context is valid and its key is the same as
>  	 * the MIC register, there's nothing to do.
> @@ -1359,7 +1362,7 @@ static int micsetup(struct airo_info *ai) {
>  	int i;
>  
>  	if (ai->tfm == NULL)
> -		ai->tfm = crypto_alloc_cipher("aes", 0, 0);
> +		ai->tfm = crypto_alloc_sync_skcipher("ctr(aes)", 0, 0);
>  
>          if (IS_ERR(ai->tfm)) {
>                  airo_print_err(ai->dev->name, "failed to load transform for AES");
> @@ -1624,37 +1627,31 @@ static void MoveWindow(miccntx *context, u32 micSeq)
>  
>  /* mic accumulate */
>  #define MIC_ACCUM(val)	\
> -	context->accum += (u64)(val) * context->coeff[coeff_position++];
> -
> -static unsigned char aes_counter[16];
> +	context->accum += (u64)(val) * be32_to_cpu(context->coeff[coeff_position++]);

You could alternatively call be32_to_cpu_array() after the AES encryption.
But this works too.

>  
>  /* expand the key to fill the MMH coefficient array */
>  static void emmh32_setseed(emmh32_context *context, u8 *pkey, int keylen,
> -			   struct crypto_cipher *tfm)
> +			   struct crypto_sync_skcipher *tfm)
>  {
>    /* take the keying material, expand if necessary, truncate at 16-bytes */
>    /* run through AES counter mode to generate context->coeff[] */
>    
> -	int i,j;
> -	u32 counter;
> -	u8 *cipher, plain[16];
> -
> -	crypto_cipher_setkey(tfm, pkey, 16);
> -	counter = 0;
> -	for (i = 0; i < ARRAY_SIZE(context->coeff); ) {
> -		aes_counter[15] = (u8)(counter >> 0);
> -		aes_counter[14] = (u8)(counter >> 8);
> -		aes_counter[13] = (u8)(counter >> 16);
> -		aes_counter[12] = (u8)(counter >> 24);
> -		counter++;
> -		memcpy (plain, aes_counter, 16);
> -		crypto_cipher_encrypt_one(tfm, plain, plain);
> -		cipher = plain;
> -		for (j = 0; (j < 16) && (i < ARRAY_SIZE(context->coeff)); ) {
> -			context->coeff[i++] = ntohl(*(__be32 *)&cipher[j]);
> -			j += 4;
> -		}
> -	}
> +	SYNC_SKCIPHER_REQUEST_ON_STACK(req, tfm);
> +	struct scatterlist dst, src;
> +	u8 iv[AES_BLOCK_SIZE] = {};
> +	int ret;
> +
> +	crypto_sync_skcipher_setkey(tfm, pkey, 16);
> +
> +	sg_init_one(&dst, context->coeff, sizeof(context->coeff));
> +	sg_init_one(&src, page_address(ZERO_PAGE(0)), sizeof(context->coeff));

Should add:

	BUILD_BUG_ON(sizeof(context->coeff) > PAGE_SIZE);

Or alternatively, instead of using ZERO_PAGE, just memset() the buffer to zero
and encrypt it in-place.  That would be less fragile.

> +
> +	skcipher_request_set_sync_tfm(req, tfm);
> +	skcipher_request_set_callback(req, 0, NULL, NULL);
> +	skcipher_request_set_crypt(req, &src, &dst, sizeof(context->coeff), iv);
> +
> +	ret = crypto_skcipher_encrypt(req);
> +	WARN_ON_ONCE(ret);
>  }
>  
>  /* prepare for calculation of a new mic */
> @@ -2415,7 +2412,7 @@ void stop_airo_card( struct net_device *dev, int freeres )
>  				ai->shared, ai->shared_dma);
>  		}
>          }
> -	crypto_free_cipher(ai->tfm);
> +	crypto_free_sync_skcipher(ai->tfm);
>  	del_airo_dev(ai);
>  	free_netdev( dev );
>  }
> -- 
> 2.20.1
> 

Otherwise this patch looks correct to me.

The actual crypto in this driver, on the other hand, looks very outdated and
broken.  Apparently it's implementing some Cisco proprietary extension to WEP
that uses a universal hashing based MAC, where the hash key is generated from
AES-CTR.  But the MAC is only 32 bits, and the universal hash (MMH) is
implemented incorrectly: there's an off-by-one error in emmh32_final() in the
code that is supposed to be an optimized version of 'sum % ((1ULL << 32) + 15)'.

Do we know whether anyone is actually using this, or is this just another old
driver that's sitting around unused?

- Eric
