Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B3B4E24BA
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 11:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346508AbiCUK4m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 06:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241272AbiCUK4l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 06:56:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFDB5EBD1
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 03:55:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B5B661376
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 10:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A85C340F2;
        Mon, 21 Mar 2022 10:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647860115;
        bh=fluWyv97Mjia7EvEwEBPacFQrIdej5SkVPry09Pecl4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=O53VKDFi6qLEwLwAtrEM8JC9YYyLM1zwvzvEX+9iiEQqIreu/ev7lg6/JKRpIfzt5
         pxV/gAQnk+OOOU+VZbC8F+S7wT/BQG2QigODcC9R9DzkvjnXYJ40fxlWoaUFCi5f3W
         MCTCUORD5Mox5Oo5gPY37hqzurj/xoXHqUUTSVj9MJ/Ofa+9h5lDiU9g4W67p1Ks32
         FrqUfYFf8XSgFn/2FYHqnoWQRNMcXYPxERC6pvL9zaT5ypIWSPpWvQkXTa7leWToK1
         yzIDHl+im11VRvvrTkn1K/uXhCV8r0H705TUU/HQHlkGG2+It/6++ilgd5uLPneo7z
         Uaq39qnyzlgYw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Refactor the peer delete
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1646024079-26391-1-git-send-email-quic_periyasa@quicinc.com>
References: <1646024079-26391-1-git-send-email-quic_periyasa@quicinc.com>
To:     Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164786011242.19083.9723279065487309641.kvalo@kernel.org>
Date:   Mon, 21 Mar 2022 10:55:14 +0000 (UTC)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> Introduce new helper function for peer delete to reuse this logic
> in all peer cleanup procedures. Found this in code review.
> Also this change is applicable for all the platform.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01067-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

997dc60f0855 ath11k: Refactor the peer delete

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1646024079-26391-1-git-send-email-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

