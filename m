Return-Path: <linux-wireless+bounces-2155-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE8B8315EC
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 10:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71F95B21049
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 09:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A54D1F92D;
	Thu, 18 Jan 2024 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inG1HcLk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FE61F922
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705570465; cv=none; b=anC/1CO2MXK+nzj4bO+RvAGfuSbTDxaoPWPSUDNgZ32xpzVX1UPFFIxgm6He2s9yLOS0gKkxvqnrexYPfajxLYbKuGmD3b2Ixj4uBi6yY1LhioAj+Fktzjyc4qfqN/vhWRXprB0WHvm9AIAQv8ksh9TT6XL/Sn5QJWJtiR4JjMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705570465; c=relaxed/simple;
	bh=K4hmYrfSigh/OFW30dHl4j/Rtx9uXeEgQzc98b/tYuw=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=NuRmI+LWAPhSB2ET7vpx9E1Ah9g5mQiMbb7R7cxf6F0RAKkPRODot9DKUfBCTgpiXCUjNq3jjmCYwPra5rwC7vh0ovQF+GMpkqwKMgQoVEI/yoJb21K0+YoPBMkggaQQqG1XfAvMKdj4q4QGCa2ijgAFb34i6/EA/gS6nIkzqT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inG1HcLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F637C433C7;
	Thu, 18 Jan 2024 09:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705570464;
	bh=K4hmYrfSigh/OFW30dHl4j/Rtx9uXeEgQzc98b/tYuw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=inG1HcLkAGoRGeJ6sXAVEGfSTKDGthcrgo1dOLX2qewYPDmg2APA92M2fI6xIoQoQ
	 sX0sOIEkLg40g3yofc0eoGHlPoUtibdFKaUsBemvnSUNVyaLqUI3S2oJHwRpqawmsr
	 KSAFSmn7RrGXy7Q3pDIgLSMWkSERGrCZ7gch3bPPAdNX+GJceL+y2ZbHGGgYHyz+bZ
	 KTQCVvt5ySdTJd+MLlxKYAy1MZyDA42KgARLoyu4khRqCYZFOFkI+SgCPjQjUsqWs+
	 BmBznHn8UItIGQrC9vX6KstN6YuDMKIJzCGz5gYm4k+2KZfx/ziwQM+iSSva8uSqVk
	 /L8tbkrCIDEcg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/8] wifi: rtw89: fw: add H2C command to update security
 CAM
 v2
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240115033742.16372-2-pkshih@realtek.com>
References: <20240115033742.16372-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170557046229.2797779.3889096428567748954.kvalo@kernel.org>
Date: Thu, 18 Jan 2024 09:34:23 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> To have secure connection, set key information into security CAM including
> key index, entry index and valid map. This new introduced H2C command can
> support MLO, but currently not implement yet.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patches applied to wireless-next.git, thanks.

8d666e575455 wifi: rtw89: fw: add H2C command to update security CAM v2
799261930656 wifi: rtw89: fw: fill CMAC table to associated station for WiFi 7 chips
7e24cc86c9c9 wifi: rtw89: fw: add chip_ops to update CMAC table to associated station
999db6f48b28 wifi: rtw89: fw: update TX AMPDU parameter to CMAC table
3d49ed071582 wifi: rtw89: fw: add H2C command to reset CMAC table for WiFi 7
011e276865d3 wifi: rtw89: fw: add H2C command to reset DMAC table for WiFi 7
85eacdcabd0f wifi: rtw89: fw: use struct to fill JOIN H2C command
3832a9c40b35 wifi: rtw89: fw: extend JOIN H2C command to support WiFi 7 chips

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240115033742.16372-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


