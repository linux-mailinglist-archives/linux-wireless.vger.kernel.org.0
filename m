Return-Path: <linux-wireless+bounces-12404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A27C96A694
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18316287B19
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 18:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4672E19259D;
	Tue,  3 Sep 2024 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdbiZPgh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6F5192593;
	Tue,  3 Sep 2024 18:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388306; cv=none; b=A+pKwmSQdcCpa2Fisap58d40zGg1mBM3rkejMgg8aMuynnXUOXzOtxPawUV1PsDEPwd0yZzY4C+/QhMSITZITN8ma5RjvBn6X81jnUY8+maPJvp6FTqWB1oxqUii3STyDgAbPeoCEewPkUQORqnEwsxGbQu6C0SDGLdBQyL56CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388306; c=relaxed/simple;
	bh=sgUrbDsgYscacQsZqjAiZTrDoEL5iJU8WjomajlfMC4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=qdneDtPxLHHuJSu/+I0TOEkqjE+04fApCC7p7efzy8vqiArOKbToPv0UDzrTQZojkRJ9atXJ8dvNiTbGFgbi0hq4l1JF4z18MWQ2j98DabeaPIL07bo9zjEEvHcQo445JII6NNTaycXSBo4nac/dZLchyY73Umu06+DXhdO7cMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdbiZPgh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A6DC4CEC4;
	Tue,  3 Sep 2024 18:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725388305;
	bh=sgUrbDsgYscacQsZqjAiZTrDoEL5iJU8WjomajlfMC4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=sdbiZPghF7VG8Kv7Q/OXUnTrGCctjqvzHav7dZf3ICbuBQjCoGJPBHA8m8Dyq+R0S
	 m3tdJLvpIEtvJojvI9v1tOGyWAVGyAIOIbax0C24hDdW1zQb6GO+XkPMtakeEuTg5Z
	 JpZxgxVWD1Fkep0dGbnSrNNEVKi+YaZW70ZPR9e5vNXvDHC7h1g/IQpr3A8bWflg7P
	 KPPH97/JEtp1lSw6bzwNat/VXQixpPZ9kFiU4fBSr3Hf5ja/DJxQGR9cwATAGiYBmi
	 7dDVZEl063eMchvI7P80M3W45ZQCavBbRc5ylf0D1INxERdx/nLHzeI1PURFc6kCDN
	 n2wi8HFmf6zlQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v3] wifi: mwifiex: Convert to use jiffies macro
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240823070320.430753-1-chenyufan@vivo.com>
References: <20240823070320.430753-1-chenyufan@vivo.com>
To: Chen Yufan <chenyufan@vivo.com>
Cc: Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Chen Yufan <chenyufan@vivo.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172538830238.1029035.5652329276730564068.kvalo@kernel.org>
Date: Tue,  3 Sep 2024 18:31:43 +0000 (UTC)

Chen Yufan <chenyufan@vivo.com> wrote:

> Use time_after macro instead of using jiffies directly to handle wraparound.
> Change the type to to unsigned long to avoid unnecessary casts.
> 
> Signed-off-by: Chen Yufan <chenyufan@vivo.com>
> Acked-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-next.git, thanks.

97b766f989bc wifi: mwifiex: Convert to use jiffies macro

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240823070320.430753-1-chenyufan@vivo.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


