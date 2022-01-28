Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920D949FD2E
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 16:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243786AbiA1Pzg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 10:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239060AbiA1Pzf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 10:55:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B6FC061714
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 07:55:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 224F2B80D5F
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 15:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D476C340E0;
        Fri, 28 Jan 2022 15:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385332;
        bh=K6TxtkxMYC4th4ydi24KWdQh1m66ehfGCuRKPZq7JBI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=S4/0WwUh0BU3RSfMsYVydqP3jFycmwp6yZWV4GEpY8h4n2w6xFM75yFGvlqwvIvJ5
         CAlnV7Bfo1HJTYMVcKdD0uiOoLZpbGL11DCRZqhYoGJpGYiR+OO+x1KgCDL409rCas
         Kl3AtJzZxRD1ZOLskOhpFGzaHMN49gSg03c/Ly1Pzoi06vHekVQb51t1KIyctAY1N4
         1LmC/9RxMNqKt6sh6novRWb4JCKR/eI9NC3bLVGMTN0MMaSZHTJBWpD/VKooZMm2Fp
         g9X3BBk9g2/YVpEdBfv14BM/YxcnxF35ed28z3ryNW1AQekG+SB6vSrUilewAPJbdR
         P59pyfJestmxA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw89: remove duplicate definition of hardware port
 number
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211227083134.35248-1-pkshih@realtek.com>
References: <20211227083134.35248-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164338533062.19531.11405304970102652467.kvalo@kernel.org>
Date:   Fri, 28 Jan 2022 15:55:32 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> RTW89_MAX_HW_PORT_NUM and RTW89_PORT_NUM refer to the same thing, so remove
> the one of them.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

20d9fc889a59 rtw89: remove duplicate definition of hardware port number

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211227083134.35248-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

