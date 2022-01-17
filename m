Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395D94908DB
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jan 2022 13:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbiAQMmp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jan 2022 07:42:45 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55480 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbiAQMmp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jan 2022 07:42:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41C31611B8
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jan 2022 12:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E111CC36AE7;
        Mon, 17 Jan 2022 12:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642423364;
        bh=G7ZxgDzPO+AOO9hsFvL6frkTOmYVsqtDIRGxHHQd1r0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Kft+4HzViN+bc+gOyhuSYWxn+3AWSAaCYDq09SRV0vpZF7fFjcOtG8gkC6sYY54iQ
         5X7GY2gsB2SUpazFCfOJaXWmwnornHFm/N76O+x7n81X0dFpS/a8Sf2wHAhYO4Odg9
         k/5Z/qd7cKhE/1Jj31OJEbn2XJgngeMoh8+P1+gmHH6/hQYUk5qhyitJXA2gzkkEaO
         6bIdtsbnZSdCkcj48coq+00VIOMgwlqBRfz2Iir6qrTdZM5UC8Qe4EQV00QwSJSGUg
         HJIzQpI0PXJz8DX/fSwCyI8GMCKezwSoPtbwQPQnhX305hqph1FCGMUlrO0eBBBOLy
         vMxBC1YZKvt5w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath11k: Reconfigure hardware rate for WCN6855 after
 vdev
 is started
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220112025400.2222-1-quic_bqiang@quicinc.com>
References: <20220112025400.2222-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164242336225.27899.2887641873424992546.kvalo@kernel.org>
Date:   Mon, 17 Jan 2022 12:42:43 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> There is an issue that WCN6855 tries to connect to an AP using
> a hardware rate of 1Mb/s , even though the AP has announced
> expected rates as [24, 36, 48, 54] in Probe Response frame.
> 
> The reason is that WCN6855 firmware clears hardware rate info
> of management frames when vdev starts and uses 1Mb/s as default.
> To solve it, reconfigure the rate after vdev is started.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

dc7ff75690ea ath11k: Reconfigure hardware rate for WCN6855 after vdev is started

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220112025400.2222-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

