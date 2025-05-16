Return-Path: <linux-wireless+bounces-23046-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF96AB935F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 03:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662555011A1
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 01:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150BD1DDC15;
	Fri, 16 May 2025 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Yo//DUmp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FB51DD877
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747357199; cv=none; b=PRd7fUi5ytOzxzJjQ8Mgud+gdVbvG/DjWs0CbVhqST2rviwOU3+Sq39Tnr2MTpWZMWDcXkA42i0WWjCDvhskRz+w02k4ihNITu9UNP8u5Tob6H3qmiygdry4G3uDx9/F2sulN4HPfIMhHyHuTnqU9Zf9HvmKYeryJvwPVRXouhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747357199; c=relaxed/simple;
	bh=hAfFK6qPYJedi/GoR0BP+Fbye3lYqhTEPynZthuTpSM=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=K6ia4L1QLBD+OuRwobAQrlB8xgIA8Apm07fI1XPs/hbGGN5wKFA0Wf43CSFCyYa+6LjNzfh+2z2xtnvPWeU8SrcQOhIu3G57w6xydsKlcfgSBc3zyxooN9aQHot1OmfERTpezFjrPOHTbLot0lrW0+M1ETizokDS+AUkrUA7STY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Yo//DUmp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54G0xsYN3071390, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747357194; bh=hAfFK6qPYJedi/GoR0BP+Fbye3lYqhTEPynZthuTpSM=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=Yo//DUmp+8l6CGcsFB5BEp/A0klPLFb/3UzGvh6Tug7mB1pNm/EcUspsAnWe1KT6V
	 k4DwqKgx7inkU7JS0WdZU/ifjUFPt3Kz6uSVRugRaWtjHyQ3VzvG4hJDAIruoxl2SC
	 mqGY/fwF8tVdkNe0dEeX54rlCsY5AijAPoR/kI0EmtsNBw/OsOHvlLXFOcqseSPRLX
	 dorSS1xzsPT7tmNwOrOj4xlTogAEpJibIcWS9y8LkpdM0+FpndBhNRvWEUnb7JK113
	 nuMRTBdgpAGS9VV4ZN2K3p48+kNef9N6zRJHuUKSOOxuourEM2jiCvUOXPef3mwdAB
	 UAmsANEU1CDuw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54G0xsYN3071390
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 08:59:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 May 2025 08:59:54 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 16 May
 2025 08:59:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next 1/6] wifi: rtw89: mcc: pass whom to stop at when pausing chanctx
In-Reply-To: <20250511035217.10410-2-pkshih@realtek.com>
References: <20250511035217.10410-1-pkshih@realtek.com> <20250511035217.10410-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <33ffdbd4-ca80-484b-87d3-469e0555cbbf@RTEXMBS04.realtek.com.tw>
Date: Fri, 16 May 2025 08:59:54 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> When stopping MCC, FW can stop at a given MCC role following H2C command.
> When pausing chanctx during MCC, in general, the caller expects to process
> things with its chanctx. So, pass the caller as target and let FW stop MCC
> at it.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patch(es) applied to rtw-next branch of rtw.git, thanks.

46b607974866 wifi: rtw89: mcc: pass whom to stop at when pausing chanctx
8ee99b998fc4 wifi: rtw89: mcc: drop queued chanctx changes when stopping
7662708c00af wifi: rtw89: mcc: add courtesy mechanism conditions to P2P roles
eec9dfad1b21 wifi: rtw89: mcc: introduce calculation of anchor pattern
122b74ac9b9d wifi: rtw89: mcc: deal with non-periodic NoA
b178c1a23c5f wifi: rtw89: mcc: avoid redundant recalculations if no chance to improve

---
https://github.com/pkshih/rtw.git


