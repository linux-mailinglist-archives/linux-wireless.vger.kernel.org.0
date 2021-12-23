Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD3447E0A5
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 09:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347338AbhLWI6u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 03:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbhLWI6u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 03:58:50 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C691C061401
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 00:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:
        From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=KsJ2TJPRyi4Zv5mEmGNqe15nnzTGdMXqdmQKuv/1xbo=; b=PDeWkSzDXdeTkmrc6Q4dnySSwh
        kU7KRRkSEisyXKzj3LFsziinTbMBIq7SHNHA/TbFZ+eW8SkGWUd6Mix9NBOtMzqIs+Jlj8ax06mcj
        A6lhNwABOJRTvYwmAbP5S+D/jc2TkBcgS+xCw4Nqd/aGeB6aExgXghDxgmpEqj6f+Nls=;
Received: from p54ae97a7.dip0.t-ipconnect.de ([84.174.151.167] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1n0Jvw-0004wg-KP; Thu, 23 Dec 2021 09:58:44 +0100
Message-ID: <89da4b36-e814-9238-71a6-044af49e8de8@nbd.name>
Date:   Thu, 23 Dec 2021 09:58:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Content-Language: en-US
To:     Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <1640248077-14075-1-git-send-email-quic_periyasa@quicinc.com>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH] ath11k: Add peer rhash table support
In-Reply-To: <1640248077-14075-1-git-send-email-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-12-23 09:27, Karthikeyan Periyasamy wrote:
> When more clients (128) are connected, the UL data traffic
> KPI measurement is low compared to single client. This issue
> is due to more CPU cycles spent on the peer lookup operation
> with more clients. So reduce the peer lookup operation by
> modifying the linear based lookup operation into the rhash
> based lookup operation. This improve the peak throughput
> measurement. Since this is a software algorithm change, it is
> applicable for all the platforms.
> 
> TCP UL 128 Clients test case Observation (64bit system):
> Previous: ~550 Mbps
> Now	: ~860 Mbps
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01067-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Why does ath11k keep a separate peer list instead of just using the sta 
entry? That seems ugly and inefficient...

- Felix
