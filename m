Return-Path: <linux-wireless+bounces-2170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A7B83186D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 12:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E736F1C223FD
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 11:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC4A23776;
	Thu, 18 Jan 2024 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOvplN3P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB952376E
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705577147; cv=none; b=ouRZnToZ1K38U2VNsefFg9PGJEMYpXsDmVdhO7heLY/j2yUeVCPd9H8pWa/M/Apn5Od0D4VN/KCMjG7/hQsvkx3TajbJzWMope1rmGL2vilcmsHJKMq5bJK87GHFPmmqvxQjEkWsoizbkAW43Fckl/5rsrBfv1FG/WtBprSURD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705577147; c=relaxed/simple;
	bh=ltIlsHyncYZh9G6ou6FL9jWCun5Sv/NuVBeGOU5SsbI=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=Qp8iE2JNmkAyXDUA56InkQCpmTva00tMK0Epxlwfru86tEmYbyyBtpk4Ko8jqvrDGC0Sof+7RMGPQTmqD+VCFr2qomJ16g0Gli2+U9n7Tx/7USEjT0Ovd77fsmZNg1pW55ptJZoTaMXL0Pj9JQqEy8WxEF3z4Qf3rN4magiQsE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOvplN3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAAFC433F1;
	Thu, 18 Jan 2024 11:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705577147;
	bh=ltIlsHyncYZh9G6ou6FL9jWCun5Sv/NuVBeGOU5SsbI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=bOvplN3PatCoGmZfileyGx+SvtMipMO+1obhheXJw9QAyD0dZ7ziZudPy3ptBC8r5
	 lvRm4jniE9H6QPHF8K0PlLKBpkI9vh8WRtODBMJWf6aJAbo2TLYdoF+raKAPA+zers
	 GKZUqY53vlk3XHZngqCcaqVkmsai31nTkUN898KV3xOfDsxHHyQvAcKfqduATF5I9K
	 HdGcnGJexDEyOdN9cAW1Vd/IumfdGJCTqC/OPHjuMi+dpXUR5Dk3MFYp6hHo9dZ5SE
	 7A/ncDDG7An0HviDsbQqXkHm3K2qpFLviYmmM1w+jqvayLUcLbCbW6uWqc46NveUnx
	 HSvCMupCtRXSQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] brcmfmac: replace one-element array with
 flexible-array
 member
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230803052238.12147-2-rauji.raut@gmail.com>
References: <20230803052238.12147-2-rauji.raut@gmail.com>
To: Atul Raut <rauji.raut@gmail.com>
Cc: aspriel@gmail.com, franky.lin@broadcom.com,
 linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel-mentees@lists.linuxfoundation.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170557714390.2924528.17502971662803875744.kvalo@kernel.org>
Date: Thu, 18 Jan 2024 11:25:45 +0000 (UTC)

Atul Raut <rauji.raut@gmail.com> wrote:

> One-element arrays are obsolete, and flexible
> array members have taken their place. So, in
> struct cca_stats_n_flags, replace the one-element
> array with a flexible-array member.
> 
> This fixes warnings such as:
> ./drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:119:6-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> 
> Signed-off-by: Atul Raut <rauji.raut@gmail.com>

Arend, what do you think? Link to the patch after "--" line.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230803052238.12147-2-rauji.raut@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


