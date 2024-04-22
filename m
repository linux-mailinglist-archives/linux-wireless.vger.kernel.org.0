Return-Path: <linux-wireless+bounces-6609-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 267F08AC290
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 03:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF3D1F2115B
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 01:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B17615B7;
	Mon, 22 Apr 2024 01:38:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ED4567D
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 01:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713749883; cv=none; b=H2scwKiqFsOmJ0zq4RmEMln9pEIleb+WscX6VRrJUGyOaIMJU+9bWhQIocjJeC2XX8qcluwf+kmC2n/npE5rVRhCabSvFLAXBS1bsW/Wsq52Ls/hXhmh3TpKscvvQLC10ybKTGQax3t2HkOdZr/SRufwWTo1WVMvk9khp0nHsGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713749883; c=relaxed/simple;
	bh=hoCRdzYStWUQaBIgGvUcxfe9L1XE57myAKu0plRoldU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=rYdEmU51Z5uUL65wDFE65iS3awAHhEWxXmQyzkrQCbS4jBN6wQ2oK0+bw3JETQB+D68Jf1VQ8fvlxQWKYLO1nj7caZDG6DZ8zIEbUQcjVyHZadQ/DssmtEyZf0lFfzmCQA02sUElrtT+4227q5D3vVE6KsIt0uWum62t/2p2FR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43M1bu4cB3700864, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43M1bu4cB3700864
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 09:37:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 09:37:57 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 09:37:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <lewis.robbins2@gmail.com>
Subject: Re: [PATCH v2] wifi: rtw88: suppress messages of failed to flush queue
In-Reply-To: <20240418002916.5965-1-pkshih@realtek.com>
References: <20240418002916.5965-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <d68acdbe-1924-4f23-9489-ab1a9c7a7302@RTEXMBS04.realtek.com.tw>
Date: Mon, 22 Apr 2024 09:37:57 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Driver throws messages when scanning with a lot of traffic, because packets
> in TX buffer can not be transmitted in time. Since this is a common
> occurrence, change them to debug message with special debug mask that
> developers can turn on this mask by default for further analysis.
> 
> Cc: Lewis Robbins <lewis.robbins2@gmail.com>
> Tested-by: Lewis Robbins <lewis.robbins2@gmail.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

8cb090b70068 wifi: rtw88: suppress messages of failed to flush queue

---
https://github.com/pkshih/rtw.git


