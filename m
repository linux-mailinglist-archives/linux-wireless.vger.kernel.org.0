Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978406F6559
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 08:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjEDG4F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 02:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEDG4E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 02:56:04 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C41E4
        for <linux-wireless@vger.kernel.org>; Wed,  3 May 2023 23:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=/nx2+yIFcilyTdI+v44iqtc/DUPgyPGwKYSoJq28jr0=;
        t=1683183363; x=1684392963; b=FKwl9gEZoRVJrISPdOKHf5i3eYsyCNeT/mQD3gBIRb8vWQU
        rNXvzEI0UPbJcmbUZXTt4e6xsDqdgnxogJDKUgzJs3co8xzQG4GlkfiMrCdrWYWqmr/w3ezdLQbGO
        PzJn+s7VMs8WJ2kHtHVtTCadtsCKkiDuvGJ2jjIHyTx9l1OIeEmX54wRiCN3dWqyVzNnqYbT3dQ5y
        9nbUn3RHheunkWNbdhft0UnRQhwcXWPrZLMPem0fomjHVXDDyHPTuXMFzPiDOloZ7RJD677kDfyhc
        eTWOQcTw7A/Zwpxk6r1zCom8w4tlR1+Sy8QInTuwIPdVtss7xzh+4fbhfHMSVTRQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1puSsj-00GpbH-0o;
        Thu, 04 May 2023 08:56:01 +0200
Message-ID: <2362effcd29ca81e5024545a8d050d7f05a2b1d2.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: S1G rate information and calculations
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com
Date:   Thu, 04 May 2023 08:56:00 +0200
In-Reply-To: <20230504024923.1925530-1-gilad.itzkovitch@morsemicro.com>
References: <20230504024923.1925530-1-gilad.itzkovitch@morsemicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2023-05-04 at 14:49 +1200, Gilad Itzkovitch wrote:
>=20
>   * Information about a receiving or transmitting bitrate
>   *
>   * @flags: bitflag of flags from &enum rate_info_flags
> - * @mcs: mcs index if struct describes an HT/VHT/HE rate
>   * @legacy: bitrate in 100kbit/s for 802.11abg
> + * @mcs: mcs index if struct describes an HT/VHT/HE rate

Did you mean to add S1G to this list? Not sure why else you moved it at
all :) And maybe if yes, add EHT while at it. But I can do that
separately too, or maybe we should just remove the list and say "if not
legacy" or something...


But I can also just change that when I commit it, if you prefer/don't
mind.

>   * @nss: number of streams (VHT & HE only)
>   * @bw: bandwidth (from &enum rate_info_bw)
>   * @he_gi: HE guard interval (from &enum nl80211_he_gi)
> @@ -1761,9 +1773,9 @@ enum rate_info_bw {
>   *	only valid if bw is %RATE_INFO_BW_EHT_RU)
>   */
>  struct rate_info {
> -	u8 flags;
> -	u8 mcs;
> +	u16 flags;
>  	u16 legacy;
> +	u8 mcs;

Oh ... I see, you moved the kernel-doc because of this reordering? No
need to do that, FWIW, the kernel-doc order doesn't really matter.

But thanks for doing this reordering to keep the struct without holes!

johannes
