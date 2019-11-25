Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14C2A108D9C
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 13:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfKYMMb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 07:12:31 -0500
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:50564
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725823AbfKYMMa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 07:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574683949;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=saokk9WmANN+C8ayw+t+pgMh7y6LLWQgSH1we9CHsyU=;
        b=dTAWnpbpmYBXFVULkzWWuOsibw5svw7ybdHHmZ81aI2reitPIPSptfKK4gDAJ+oQ
        Rcn5JAInbEjXkNO4Iz/CItOLhGQg4Hj8fFaZV84SnVu+DNh9FHMjfgWrtWXP6ljHNTw
        Jn4ZozE6k/QLCNJSTKoJl7qfDdvKK7zenVWiZNyM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574683949;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=saokk9WmANN+C8ayw+t+pgMh7y6LLWQgSH1we9CHsyU=;
        b=C2HdLioPKl1pHRYs8WlU24sOpzJTZ4mj0fZlkA8JqISUoPx0AqutakorW+KBAqnt
        O4qPAj4hnBas2fTJ1mUFQcALPmDP0BP/EmWzhkdmvEDUlzo06FxT5T9k3GUG6QFrB88
        hpdY5bjQSXViKEganbl2Z2rot+P5kGmT/6Eur/GU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86684C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: report rssi of each chain to mac80211 for sdio
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191114111931.27800-1-wgong@codeaurora.org>
References: <20191114111931.27800-1-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016ea27a3a3b-b700b1f9-581d-4a19-80b9-1a0d40e6f3c8-000000@us-west-2.amazonses.com>
Date:   Mon, 25 Nov 2019 12:12:29 +0000
X-SES-Outgoing: 2019.11.25-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> iw command only show rssi without each chain's rssi on sdio
> iw wlan0 station dump
> Station a0:40:a0:93:3e:de (on wlan0)
> signal:         -82 dBm
> signal avg:     -82 dBm
> 
> after this patch, it will show each chain's rssi on sdio
> Station a0:40:a0:93:3e:de (on wlan0)
> signal:         -82 [-84, -88] dBm
> signal avg:     -82 [-84, -87] dBm
> 
> For QCA6174 PCIe, the ppdu have the correct rssi of each chain, it
> indicate rssi of rx data by ath10k_htt_rx_h_signal. For sdio chip, the
> rssi of each chain stored in rx management reported by firmware, the
> ath10k_wmi_tlv_op_pull_mgmt_rx_ev which used for tlv wmi will get the
> rssi of each chain and stored them in wmi_mgmt_rx_ev_arg, then indicate
> them to mac80211. For non-tlv wmi chip, it will not get the rssi of each
> chain and not indicate to mac80211, for non-tlv wmi chip, this patch will
> not have impact. For tlv wmi chip, if the rssi of chain in mgmt is valid,
> it will be indicate to mac80211, tested with QCA6174 PCIe/SDIO, the rssi
> of 2 chain in mgmt is valid.
> 
> rssi of chains in mgmt of QCA6174 SDIO:
> 92096.652780: ath10k:ath10k_log_warn: ath10k_sdio mmc1:0001:1 rssi[0]:70
> 92096.657324: ath10k:ath10k_log_warn: ath10k_sdio mmc1:0001:1 rssi[1]:68
> 92096.662009: ath10k:ath10k_log_warn: ath10k_sdio mmc1:0001:1 rssi[2]:128
> 92096.666647: ath10k:ath10k_log_warn: ath10k_sdio mmc1:0001:1 rssi[3]:128
> 
> rssi of chains in mgmt of QCA6174 PCIe:
> [ 1581.049816] ath10k_pci 0000:02:00.0: mgmt rssi[0]:17
> [ 1581.049818] ath10k_pci 0000:02:00.0: mgmt rssi[1]:22
> [ 1581.049821] ath10k_pci 0000:02:00.0: mgmt rssi[2]:128
> [ 1581.049823] ath10k_pci 0000:02:00.0: mgmt rssi[3]:128
> 
> after apply this patch, the iw's rssi of PCIe do not changed, result is
> same with before.
> 
> iw wlan0 station dump of QCA6174 PCIe:
> Station 6c:e8:73:b8:92:dc (on wlan0)
>         signal:         -70 [-77, -72] dBm
>         signal avg:     -69 [-78, -72] dBm
> 
> iw wlan-5000mhz station dump of QCA9984 PCIe
> connected with 2 client which has 2 chain:
> Station 70:48:0f:1f:1a:b2 (on wlan-5000mhz)
>         signal:         -47 [-55, -48, -87, -88] dBm
>         signal avg:     -42 [-50, -43, -83, -86] dBm
> Station ac:c1:ee:39:e3:83 (on wlan-5000mhz)
>         signal:         -43 [-46, -45, -79, -84] dBm
>         signal avg:     -43 [-46, -46, -82, -83] dBm
> 
> Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00017-QCARMSWP-1.
> Tested with QCA6174 PCIe with firmware WLAN.RM.4.4.1-00110-QCARMSWP-1.
> Tested with QCA9984 PCIe with firmware 10.4-3.9.0.2-00040.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

7005eafc1f1c ath10k: report rssi of each chain to mac80211 for sdio

-- 
https://patchwork.kernel.org/patch/11243567/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

