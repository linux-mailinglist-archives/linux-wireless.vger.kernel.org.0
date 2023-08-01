Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A08976BC03
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 20:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjHASMI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 14:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjHASMH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 14:12:07 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877E21723
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 11:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DlagEVz453QJUjBNbPYd1lhPyRMGX1iNOD/8nGdB6UM=; b=P976Kv7ofC9NQXP7kjGHtZNhSm
        N6YbgvTB8Di+vDfCTAtXo8gTfFdNqQ4eriH+4IdJpEpaM60DZgzOS9ScYDD0+TcWL/VcR4T3EgCnM
        d0c/x9PB9a4jVxCM5x+AOkYMomvTwz51y3/JZt5Bha/mPtjzzxzHtoDeJ4+1yUuDc9vg=;
Received: from p4ff134dd.dip0.t-ipconnect.de ([79.241.52.221] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1qQtqZ-0048Nn-SE; Tue, 01 Aug 2023 20:11:51 +0200
Message-ID: <a8986afb-3e92-8314-d932-3f2bc8ca1936@nbd.name>
Date:   Tue, 1 Aug 2023 20:11:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] ath11k: Don't drop tx_status when peer cannot be
 found
Content-Language: en-US
To:     Sven Eckelmann <sven@narfation.org>, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Cc:     Kalle Valo <quic_kvalo@quicinc.com>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <20230801-ath11k-ack_status_leak-v1-1-539cb72c55bc@narfation.org>
From:   Felix Fietkau <nbd@nbd.name>
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <20230801-ath11k-ack_status_leak-v1-1-539cb72c55bc@narfation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 01.08.23 19:38, Sven Eckelmann wrote:
> When a station idles for a long time, hostapd will try to send a QoS Null
> frame to the station as "poll". NL80211_CMD_PROBE_CLIENT is used for this
> purpose. And the skb will be added to ack_status_frame - waiting for a
> tx_complete via ieee80211_tx_status*();
> 
> But when the peer was already removed before the tx_complete arrives, the
> peer will be missing and thus the entry will not be removed from
> ack_status_frame. This IDR will therefore run full after 8K clients which
> disappeared this way - the access point will then just stall and not allow
> any new clients because idr_alloc for ack_status_frame will fail.
> 
> Tested-on: IPQ6018 hw1.0 WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 6257c702264c ("wifi: ath11k: fix tx status reporting in encap offload mode")
> Fixes: 94739d45c388 ("ath11k: switch to using ieee80211_tx_status_ext()")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> This problem can be seen with QCA's ath11k fork as:
> 
>    attach ack fail -28
> 
> when new clients try to connect - and connection attempt will obviously
> fail. Most likely with an "deauthenticated due to inactivity (timer
> DEAUTH/REMOVE)" by hostapd.
> 
> And the fix (required for both platches) would then be something like:
> 
>    --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
>    +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
>    @@ -629,8 +629,14 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
>     			   "dp_tx: failed to find the peer with peer_id %d\n",
>     			    ts->peer_id);
>     		spin_unlock_bh(&ab->base_lock);
>    -		dev_kfree_skb_any(msdu);
>    -		goto exit;
>    +		rcu_read_unlock();
>    +
>    +		if (skb_cb->flags & ATH11K_SKB_HW_80211_ENCAP)
>    +			ieee80211_tx_status_8023(ar->hw, skb_cb->vif, msdu);
>    +		else
>    +			ieee80211_tx_status(ar->hw, msdu);
>    +
>    +		return;
>     	}
>     	arsta = (struct ath11k_sta *)peer->sta->drv_priv;
>     	status.sta = peer->sta;
> 
> But this is not possible any longer because Felix Fietkau removed
> ieee80211_tx_status_8023 in commit 9ae708f00161 ("wifi: mac80211: remove
> ieee80211_tx_status_8023") - and the function ieee80211_lookup_ra_sta
> (required for this task) is currently not exported. And the sta information
> is required to reach the ieee80211_sta_tx_notify code section in
> ieee80211_tx_status_ext()

This does not make much sense to me. ieee80211_sta_tx_notify is specific 
to interfaces running in client mode, thus unrelated to anything hostapd 
is doing. It's a different kind of probing than the one you're looking into.

If the status information is irrelevant to mac80211/hostapd, then there 
really is no need to call ieee80211_tx_status* here.

The main bug is the fact that dev_kfree_skb* must not be called for tx 
packets passed from mac80211. If you replace it with a call to 
ieee80211_free_txskb, the bug goes away.

One more note regarding ieee80211_tx_status_8023 - I removed it not only 
because it was unused, but because it should never be used at all. Its 
call to ieee80211_lookup_ra_sta is guaranteed to be broken whenever 
4-address mode AP_VLAN is being used (since the driver cannot pass the 
correct vif).

- Felix
