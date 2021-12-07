Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A4B46BEA1
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 16:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbhLGPKG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 10:10:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60774 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbhLGPKG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 10:10:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 553D2B80782
        for <linux-wireless@vger.kernel.org>; Tue,  7 Dec 2021 15:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782FCC341C3;
        Tue,  7 Dec 2021 15:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638889594;
        bh=Aqlt0Umd9U45tnfd/lxOHJT3Z79bljrdouNxS3a0SBo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=DyRZ2xgJG3059KoXVDOVACnD5a8O6gpee+EZWerjkd78gWcKSkJJPRcyWaXdzkf4o
         6rODVVA/jn+sMTpu3h1IpvgBjVyPng2AmPJo4QxiLzFiGmU+O7t2Hnsvw3+rlxmGqW
         ehz7oAjZvHXXD8sJ0V8ZwCDpArbkB8JZ9QXz/zDOsPf7vQMz37gkVT1I5R5mtxO5bJ
         elISpT/baRZDXrEcOoHzZWQJheUofL7Sfh1NAv6RP+ObjbuI5mLE3LqptP+p1Z2eg9
         JtcMz+i/QCTDrDj+DPCwkF4Pu+8PrsFSpCM7pogy3o+06hAbpN3LMBnUSj8u0kED8r
         lzOCn9nvBqWIg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-drivers] MAINTAINERS: update Kalle Valo's email
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211201133952.31744-1-kvalo@kernel.org>
References: <20211201133952.31744-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163888959073.5012.11213299648417587848.kvalo@kernel.org>
Date:   Tue,  7 Dec 2021 15:06:33 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> I switched to using kvalo@kernel.org, update MAINTAINERS file.
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>

Patch applied to wireless-drivers.git, thanks.

06d59d626a0a MAINTAINERS: update Kalle Valo's email

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211201133952.31744-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

