Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF7B452C86
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Nov 2021 09:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhKPISx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Nov 2021 03:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhKPISw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Nov 2021 03:18:52 -0500
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328CAC061570
        for <linux-wireless@vger.kernel.org>; Tue, 16 Nov 2021 00:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1637050553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HCRpBqCtrSEkFE0UglxhQwZOg1eNQ0wU2h//182ccAs=;
        b=xb7sP81LNmgTnmuh2lpA/n4ceNyBFLX1DqXoYR87SMXLuIjTTkN/3sZZQknF7zXqob6JJc
        BHOBiCFl4LMLBj2xZrJ9Jsddx8sw7c8frGv5aZnXbx0XyiJd3lnt5vINV74fGyf88QSrRd
        B6pssAj+N8Z/NmKTFXwLhzIdDzAslQY=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org, Wen Gong <quic_wgong@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 3/4] ath11k: add support for device recovery for QCA6390
Date:   Tue, 16 Nov 2021 09:15:44 +0100
Message-ID: <1752085.FWK5zBq28I@ripper>
In-Reply-To: <20211116041522.23529-4-quic_wgong@quicinc.com>
References: <20211116041522.23529-1-quic_wgong@quicinc.com> <20211116041522.23529-4-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3442281.K65GMkSaLI"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart3442281.K65GMkSaLI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: ath11k@lists.infradead.org, Wen Gong <quic_wgong@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 3/4] ath11k: add support for device recovery for QCA6390
Date: Tue, 16 Nov 2021 09:15:44 +0100
Message-ID: <1752085.FWK5zBq28I@ripper>
In-Reply-To: <20211116041522.23529-4-quic_wgong@quicinc.com>
References: <20211116041522.23529-1-quic_wgong@quicinc.com> <20211116041522.23529-4-quic_wgong@quicinc.com>

On Tuesday, 16 November 2021 05:15:21 CET Wen Gong wrote:
> Currently ath11k has device recovery logic, it is introduced by this
> patch "ath11k: Add support for subsystem recovery" which is upstream
> by https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=ath11k-bringup&id=3a7b4838b6f6f234239f263ef3dc02e612a083ad.

https://www.kernel.org/doc/html/v5.15/process/submitting-patches.html#describe-your-changes

Please search for "If you want to refer to a specific commit"
And this commit you referenced is definitely not the upstream commit.
It was only part of Kalle's repository. The code was only upstreamed
with commit d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax
devices").


Btw. another thing which I see again and again in these patches:

> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -39,6 +39,10 @@
[...]
> +       bool is_reset;

https://www.kernel.org/doc/html/v5.15/process/coding-style.html#using-bool

"If a structure has many true/false values, consider consolidating them into a 
bitfield with 1 bit members, or using an appropriate fixed width type, such as 
u8."

There are more verbose mails from Linus Torvalds where he points out the 
problems of bools in structs. See for example struct ath11k_skb_rxcb. At
the moment, it looks like this:

    struct ath11k_skb_rxcb {
    	dma_addr_t paddr;
    	bool is_first_msdu;
    	bool is_last_msdu;
    	bool is_continuation;
    	bool is_mcbc;
    	bool is_eapol_tkip;
    	struct hal_rx_desc *rx_desc;
    	u8 err_rel_src;
    	u8 err_code;
    	u8 mac_id;
    	u8 unmapped;
    	u8 is_frag;
    	u8 tid;
    	u16 peer_id;
    	u16 seq_no;
    	struct napi_struct *napi;
    };

Compiled for IPQ60xx, it would end up as:

    $ pahole ./drivers/net/wireless/ath/ath11k/ath11k.o -C ath11k_skb_rxcb
    struct ath11k_skb_rxcb {
            dma_addr_t                 paddr;                /*     0     8 */
            bool                       is_first_msdu;        /*     8     1 */
            bool                       is_last_msdu;         /*     9     1 */
            bool                       is_continuation;      /*    10     1 */
            bool                       is_mcbc;              /*    11     1 */
            bool                       is_eapol_tkip;        /*    12     1 */
    
            /* XXX 3 bytes hole, try to pack */
    
            struct hal_rx_desc *       rx_desc;              /*    16     8 */
            u8                         err_rel_src;          /*    24     1 */
            u8                         err_code;             /*    25     1 */
            u8                         mac_id;               /*    26     1 */
            u8                         unmapped;             /*    27     1 */
            u8                         is_frag;              /*    28     1 */
            u8                         tid;                  /*    29     1 */
            u16                        peer_id;              /*    30     2 */
            u16                        seq_no;               /*    32     2 */
    
            /* XXX 6 bytes hole, try to pack */
    
            struct napi_struct *       napi;                 /*    40     8 */
    
            /* size: 48, cachelines: 1, members: 16 */
            /* sum members: 39, holes: 2, sum holes: 9 */
            /* last cacheline: 48 bytes */
    };

After changing it to u8 ....:1 and reorganizing the structure:

    $ pahole drivers/net/wireless/ath/ath11k/ath11k.o -C ath11k_skb_rxcb -R
    struct ath11k_skb_rxcb {
            dma_addr_t                 paddr;                /*     0     8 */
            struct hal_rx_desc *       rx_desc;              /*     8     8 */
            struct napi_struct *       napi;                 /*    16     8 */
            u8                         err_rel_src;          /*    24     1 */
            u8                         err_code;             /*    25     1 */
            u8                         mac_id;               /*    26     1 */
            u8                         unmapped;             /*    27     1 */
            u8                         is_frag;              /*    28     1 */
            u8                         tid;                  /*    29     1 */
            u8                         is_first_msdu:1;      /*    30: 0  1 */
            u8                         is_last_msdu:1;       /*    30: 1  1 */
            u8                         is_continuation:1;    /*    30: 2  1 */
            u8                         is_mcbc:1;            /*    30: 3  1 */
            u8                         is_eapol_tkip:1;      /*    30: 4  1 */
    
            /* XXX 3 bits hole, try to pack */
            /* XXX 1 byte hole, try to pack */
    
            u16                        peer_id;              /*    32     2 */
            u16                        seq_no;               /*    34     2 */
    
            /* size: 40, cachelines: 1, members: 16 */
            /* sum members: 34, holes: 1, sum holes: 1 */
            /* sum bitfield members: 5 bits, bit holes: 1, sum bit holes: 3 bits */
            /* padding: 4 */
            /* last cacheline: 40 bytes */
    };



Or ath11k_bus_params:

    $ pahole ./drivers/net/wireless/ath/ath11k/ath11k.o -C ath11k_bus_params
    struct ath11k_bus_params {
            bool                       mhi_support;          /*     0     1 */
            bool                       m3_fw_support;        /*     1     1 */
            bool                       fixed_bdf_addr;       /*     2     1 */
            bool                       fixed_mem_region;     /*     3     1 */
            bool                       static_window_map;    /*     4     1 */
    
            /* size: 5, cachelines: 1, members: 5 */
            /* last cacheline: 5 bytes */
    };

After changing it to an "u8 ....:1":

    $ pahole ./drivers/net/wireless/ath/ath11k/ath11k.o -C ath11k_bus_params
    struct ath11k_bus_params {
            u8                         mhi_support:1;        /*     0: 0  1 */
            u8                         m3_fw_support:1;      /*     0: 1  1 */
            u8                         fixed_bdf_addr:1;     /*     0: 2  1 */
            u8                         fixed_mem_region:1;   /*     0: 3  1 */
            u8                         static_window_map:1;  /*     0: 4  1 */
    
            /* size: 1, cachelines: 1, members: 5 */
            /* bit_padding: 3 bits */
            /* last cacheline: 1 bytes */
    };


There are even better examples. ath11k_hw_params will for example take 
currently 200 bytes. With a little reordering and adjusting of bools,
it can easily be reduced to 152 bytes. But other structures might
have more impact because they are used more often.


Kind regards,
	Sven
--nextPart3442281.K65GMkSaLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmGTaLAACgkQXYcKB8Em
e0aMchAAj5HwF9A+HscjvAE3SyKVy4SwBgWghwe8adZXq3Ay3SX7gdc+hfLQarZV
q7HxRK5zjH/n6Ni8BO0PYk6vv+PqUND6CHmay+e9pQxZjAI/B6Er6BFmFhbnOK6e
xadJ9jm5yCugU8wou6cOqnrWctG6uWOfmNdbf1LNDsTDTx1dXRXK6jW5Zivy71BY
6DyTdHBJIT8taWlc7lWfo4LlVBxLVdayRN04kA83srpnkzcaFxzi1sJ+sbiTpyMA
G15yhjjglALJiyKUL837pyXfWPLyRjA2rdv8Ba19Ds2s8AbsIB6roRcvdg67TukN
W1fWqOTX960XWafh1x/0ZMFGoijTHcHTrFeTOf1ZoJfsi2kaaCxfeHUL8J97zV/b
53HmgO/yKO80yCneJqA3wkdzA8dDFiOK7Ss7ja1yQKvSr5PW5sraRxkzB/QGk1Fr
1JwoPbh/TQLUHV9brwDVWWdpMKv1yEnN5oQ0spjtVXBsqxiJg8o0YtrsNQip7R4O
Q27LvWEgG3XNp+/EDZsBXYRshx9+C3MQSCERkh1Wsqm8Szy1GNiUdIdR4VGMXtdp
7V3iEH29/0gxrZ2nGPfMWeD9hrRGw9r603EPVnRfM6LDwdSVaXFP+w9HyrUGE3tI
fARAoOmyKhRbaE3Vc80zd5ctZQng+fyPqcm1dy+FSKWjJeY+7qA=
=DQ25
-----END PGP SIGNATURE-----

--nextPart3442281.K65GMkSaLI--



