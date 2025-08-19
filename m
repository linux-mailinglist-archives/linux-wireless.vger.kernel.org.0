Return-Path: <linux-wireless+bounces-26440-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC482B2B5CC
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 03:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96768526D85
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 01:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17F013B280;
	Tue, 19 Aug 2025 01:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Q7YVFK1M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598502110
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 01:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566332; cv=none; b=WRDYb3pGhYcWccPTbi9RuCPXueoBFTpFjK9PWg6iYnh/tvnNmyadPtZuOFrLyK8YSp/nANWOu9Hza3JUB9tsLaOYkMZ+XqTTqC/0i6bGAovz4ziwdTJ5FDNeRwpopBLoteuaNG21HMYPqp1RPZKSST6qlAc3GxNu6LTawtSwkQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566332; c=relaxed/simple;
	bh=SGNA32Dy4CfeETQxO7uo24yV2A7PehImAgYKqqSr4pM=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=P5IFfsXU71GrmPSeW41X9wFIv0tXZOfhMn/qaL2W++BqBqxU9kq/A/tVt94hb4fvX43o9XNc7gbIUwDTBAs3LJ91roPyWq+HMxqD8WFMDG2P0/H9qf+Ckuav32fLeSizqR1vSrlUvZOnBawNbl/5bNxu5/ty/rUqPR85Duvf++4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Q7YVFK1M; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57J1IkxmE1852012, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1755566326; bh=AQZEu7ANz1RAbWXc9yVC/kJRjns/yAs/w9D2kLNZtc0=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=Q7YVFK1MmSH8pvtWWdU1KjknyxmFv0BJWUimEHPLlwTTfVjycOwaeX++0bqZuMIE2
	 cYpbejDLyINII7ztuKwO1pLJZLA/o3iwsZiVVhzfZWXiH15G7JivjW+Jzg1lCqos9n
	 pY59Jh/Hqh8wC7xDLyvYkyXZRPwMUZyCeNuh7fY+UDzV6swVcuCVMP7K1YAADK6O8e
	 v0QMpOsA6smnTKqnMt8odBJPRCO/kABXY5yJCJ2o/mehHFHjBeJFZQOazzsmaqPI0c
	 XyOe1WiwErYrfVEuZAtV7ABw0SaO/2P6S9cGTPkOhmANj0SHgdO1X1HDI9kOK6gahq
	 kUnTxw1iJZobA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57J1IkxmE1852012
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 09:18:46 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Aug 2025 09:18:47 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 09:18:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>
Subject: Re: [PATCH rtw-next 1/8] wifi: rtw89: introduce beacon tracking to improve connection stability
In-Reply-To: <20250811123744.15361-2-pkshih@realtek.com>
References: <20250811123744.15361-1-pkshih@realtek.com> <20250811123744.15361-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <c3c491a5-db26-44c9-ab17-c209c5d76060@RTKEXHMBS06.realtek.com.tw>
Date: Tue, 19 Aug 2025 09:18:46 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Kuan-Chung Chen <damon.chen@realtek.com>
> 
> In ideal scenario, AP's beacon should transmit at the Target Beacon
> Transmission Time (TBTT). However, in practice, beacon may be slightly
> off-schedule. This beacon "drift" prevents the firmware from receiving
> beacon at the expected TBTT, leading to connection disruptions.
> 
> To address this, we introduce beacon tracking mechanism to enhance overall
> connection stability. This mechanism executes the following steps in each
> cycle (2 seconds): 1) Based on the last 32 received beacons, compute the
> minimum TBTT offset to use for the next cycle 2) Using the same 32 beacons,
> calculate the drift of each. A histogram is plotted, and outliers are
> identified using a boxplot. 3) According to the statistical results from
> the second step, a maximum receive window size (beacon timeout) is selected
> to cover approximately 80% of the beacons and applied to the next cycle.
> 
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patch(es) applied to rtw-next branch of rtw.git, thanks.

d360551f265e wifi: rtw89: introduce beacon tracking to improve connection stability
194b7ce98247 wifi: rtw89: debug: add beacon_info debugfs
38846585f9df wifi: rtw89: wow: remove notify during WoWLAN net-detect
b521685da35e wifi: rtw89: 8851b: rfk: update IQK TIA setting
5b2341efbb7a wifi: rtw89: 8851b: rfk: update TX wideband IQK
46ac5412e406 wifi: rtw89: 8852c: check LPS H2C command complete by C2H reg instead of done ack
c4c16c88e784 wifi: rtw89: fix BSSID comparison for non-transmitted BSSID
bf02a01d1dd5 wifi: rtw89: fix group frames loss when connected to non-transmitted BSSID

---
https://github.com/pkshih/rtw.git


