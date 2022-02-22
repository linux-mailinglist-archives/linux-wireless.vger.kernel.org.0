Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FC64BF9ED
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Feb 2022 14:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiBVNzd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Feb 2022 08:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbiBVNzc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Feb 2022 08:55:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87456117C9B
        for <linux-wireless@vger.kernel.org>; Tue, 22 Feb 2022 05:55:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49D98B819D9
        for <linux-wireless@vger.kernel.org>; Tue, 22 Feb 2022 13:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444DBC340E8;
        Tue, 22 Feb 2022 13:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645538104;
        bh=d3Ixbs5zOqFFSUn/uSyDBoc0z2LozIOdrEAz6XPaqJQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=I3phl1BsGuQNzKVyFNNxi+hQFpQq8SNjhbNR9jlnNFx357273Nsi1Nk9u/+Wb38k/
         OaNHRJBQAq4J89dfTGFEwS+ZCcMw8nUry6IqC6cSAEenXqUlnW/ypDXwoxUpIx5Epq
         TLrNyrm3UfUMbS2W76cd0eDDFFnbQNclsCmfK1uQA9hnJiSOQe/UBxoNxSfT0TpX5t
         7keMRoG9PAgE2cE0u5p3xqIk/6riqthQvVrWZWTUnYapy2FyRSe7lpJ9VH1cCRxx5c
         mSDzixJQb2/eogZONsR8UTjh4We3C+xktXf+fwsNt+i59VB1IpOQFcqhv5X+A9v2Fy
         pMVAh2/KVNX5g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Carl Huang <quic_cjhuang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] ath11k: support GTK rekey offload
References: <1644308006-22784-1-git-send-email-quic_cjhuang@quicinc.com>
        <1644308006-22784-7-git-send-email-quic_cjhuang@quicinc.com>
Date:   Tue, 22 Feb 2022 15:54:59 +0200
In-Reply-To: <1644308006-22784-7-git-send-email-quic_cjhuang@quicinc.com>
        (Carl Huang's message of "Tue, 8 Feb 2022 16:13:26 +0800")
Message-ID: <875yp7vwek.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Carl Huang <quic_cjhuang@quicinc.com> writes:

> Host sets GTK related info to firmware before WoW is enabled, and
> gets rekey replay_count and then disables GTK rekey when WoW quits.
>
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>
> Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>

[...]

> +static void ath11k_mac_op_set_rekey_data(struct ieee80211_hw *hw,
> +					 struct ieee80211_vif *vif,
> +					 struct cfg80211_gtk_rekey_data *data)
> +{
> +	struct ath11k *ar = hw->priv;
> +	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
> +	struct ath11k_rekey_data *rekey_data = &arvif->rekey_data;
> +
> +	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "Set rekey data vdev_id %d\n",
> +		   arvif->vdev_id);
> +	mutex_lock(&ar->conf_mutex);
> +
> +	memcpy(rekey_data->kck, data->kck, NL80211_KCK_LEN);
> +	memcpy(rekey_data->kek, data->kek, NL80211_KEK_LEN);
> +
> +	/* supplicant works on big-endian, converts to cpu-endian */
> +	rekey_data->replay_ctr = be64_to_cpu(get_unaligned((u64 *)data->replay_ctr));

This has a warning:

drivers/net/wireless/ath/ath11k/mac.c:8219:34: warning: cast to restricted __be64

In the pending branch I changed this to:

	/* The supplicant works on big-endian, the firmware expects it on
	 * little endian.
	 */
	rekey_data->replay_ctr = get_unaligned_be64(data->replay_ctr);

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
