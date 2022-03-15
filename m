Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C224D9324
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Mar 2022 04:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344732AbiCODtw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Mar 2022 23:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344724AbiCODtv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Mar 2022 23:49:51 -0400
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 3466C27B1A
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 20:48:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1647316119; h=Message-ID: References: In-Reply-To: Subject:
 Subject: Cc: To: To: From: From: Date: Content-Transfer-Encoding:
 Content-Type: MIME-Version: Sender: Sender;
 bh=YtMfumrGO1RNPaPDuAV8Wr+YNVhnvY377ZQXF4qHgAk=; b=tKZBLNpT+L0K5+JCrwAkXrwoD9N1DR54fETCTSwx1f0x+Xhb6wAvVZdW8Dv2MmFOdPKKDjbg
 91fM3J+7zxRxVL1FLlv57A4AEMZbeYbhGMTSpyWx20IwLRgDFfivtNXMIdFTj/f/ZPbfiLps
 8I1L9mUSRlQiUBgqWTRF60H1dwA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 62300c95ea5f8dddb5ab7d23 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Mar 2022 03:48:37
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C4671C4361B; Tue, 15 Mar 2022 03:48:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 09DD3C4338F;
        Tue, 15 Mar 2022 03:48:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Mar 2022 20:48:36 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, quic_alokad@quicinc.com,
        john@phrozen.org, nbd@nbd.name, ryder.lee@mediatek.com,
        money.wang@mediatek.com, evelyn.tsai@mediatek.com
Subject: Re: [PATCH v14 mac80211-next 1/3] mac80211: MBSSID beacon handling in
 AP mode
In-Reply-To: <5322db3c303f431adaf191ab31c45e151dde5465.1645702516.git.lorenzo@kernel.org>
References: <cover.1645702516.git.lorenzo@kernel.org>
 <5322db3c303f431adaf191ab31c45e151dde5465.1645702516.git.lorenzo@kernel.org>
Message-ID: <6a24f667a41dbfba9639f63baa1da4db@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2022-02-24 03:54, Lorenzo Bianconi wrote:
> Add new fields in struct beacon_data to store all MBSSID elements.
> Generate a beacon template which includes all MBSSID elements.
> Move CSA offset to reflect the MBSSID element length.
> 
> Co-developed-by: Aloka Dixit <alokad@codeaurora.org>
> Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
> Co-developed-by: John Crispin <john@phrozen.org>
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---

Hi Lorenzo,
Looks like you removed the EMA portion from this ptch.
Can you please fold that in as well from v13.
Thanks.
