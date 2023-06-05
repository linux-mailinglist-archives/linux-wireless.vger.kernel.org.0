Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579437224A3
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jun 2023 13:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjFELda (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 07:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjFELd0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 07:33:26 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C851B1
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 04:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=xTlxXGdow/7xkZ1gyn9rYld59gTDefocGGkbHkRmMUE=;
        t=1685964800; x=1687174400; b=yIGsNUJMlVDrqsR4E1M0qDn4sICHaHZ6AF9RKbbmMZjng3A
        4f1cNZW/IUZxoTkrurDVPVrlFMv2EtfQFbl/oiG0ZZEaaMiO1++Ejitqf7xI4v/8JA/g5Uo51I/JJ
        N0Raf+xVb/SEBJ0ov3mLxn+EM4Twr+gJFNK3qtGR05crQoFSGe9caDnDUNnEhwTSMLIfYBgguW4ZQ
        2rghcm071AY4qxQJlOMwi2QHWmMIkA5+oLxrV+CExnMU3UDH5tGLMfIH4fY3N4a+PkUzBAiEm7/KA
        4iZ1KJ6eDK2vLgRdB6nFwm9SXjcAyrDaKtygKR0BPTlOAgcryWuZsfrq1tv8+t2A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q68SU-00EQoP-2w;
        Mon, 05 Jun 2023 13:33:11 +0200
Message-ID: <2650eae9d006abb4021d4ef8e9e43bbde99d31fd.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] wifi: mac80211: ageout BSS color bitmap
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Money Wang <money.wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Date:   Mon, 05 Jun 2023 13:33:09 +0200
In-Reply-To: <4e6b407ec7dba2baa2cbd739088ff78ab1b02756.1680553708.git.yi-chia.hsieh@mediatek.com>
References: <774ab129159408a3f3e04b7e662cb559cf087c48.1680553706.git.yi-chia.hsieh@mediatek.com>
         <4e6b407ec7dba2baa2cbd739088ff78ab1b02756.1680553708.git.yi-chia.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-04-03 at 14:04 -0700, Yi-Chia Hsieh wrote:

> +/* ageout time for OBSS BSS color */
> +#define IEEE80211_BSS_COLOR_AGEOUT_TIME		10

I don't think that should be in this file, it's implementation defined.
Also it might be nicer to just define it in jiffies, i.e. (10 * HZ),
directly.

> +++ b/include/net/mac80211.h
> @@ -750,6 +750,7 @@ struct ieee80211_bss_conf {
>  	bool color_change_active;
>  	u8 color_change_color;
>  	u64 used_color_bitmap;
> +	unsigned long color_last_seen[IEEE80211_BSS_COLOR_MAX + 1];

This is really big (512 bytes) and per link - might make sense to only
allocate when needed.

> +void ieee80211_color_aging_work(struct work_struct *work)
> +{
> +	struct ieee80211_sub_if_data *sdata =3D
> +		container_of(work, struct ieee80211_sub_if_data,
> +			     deflink.color_aging_work.work);
> +	struct ieee80211_bss_conf *bss_conf =3D &sdata->vif.bss_conf;
> +	int i;
> +
> +	sdata_lock(sdata);
> +
> +	if (!ieee80211_sdata_running(sdata))
> +		goto unlock;
> +
> +	for (i =3D 1; i < IEEE80211_BSS_COLOR_MAX + 1; i++) {
> +		/* ageout if not seen for a period */
> +		if ((bss_conf->used_color_bitmap & BIT_ULL(i)) &&
> +		    time_before(bss_conf->color_last_seen[i],
> +				jiffies - IEEE80211_BSS_COLOR_AGEOUT_TIME * HZ)) {
> +			bss_conf->used_color_bitmap &=3D ~BIT_ULL(i);
> +		}
> +	}
> +
> +	ieee80211_queue_delayed_work(&sdata->local->hw,
> +				     &sdata->deflink.color_aging_work, HZ);

What? No ... you really can't do this. Just schedule the work properly
at the right time, don't leave it running forever every 1 second!!


> @@ -1430,6 +1431,11 @@ int ieee80211_do_open(struct wireless_dev *wdev, b=
ool coming_up)
> =20
>  	set_bit(SDATA_STATE_RUNNING, &sdata->state);
> =20
> +	if (sdata->vif.type =3D=3D NL80211_IFTYPE_AP)
> +		ieee80211_queue_delayed_work(&sdata->local->hw,
> +					     &sdata->deflink.color_aging_work,
> +					     HZ);

Again, no.

johannes
