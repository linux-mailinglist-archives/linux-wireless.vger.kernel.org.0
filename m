Return-Path: <linux-wireless+bounces-25422-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE0CB04DA2
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 03:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DBD94E0739
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 01:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342261C84B8;
	Tue, 15 Jul 2025 01:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HVnDVCOb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C031BCA07
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 01:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752544776; cv=none; b=At0oYl8suuk4tfq0KYkdlh43da3RT2C8lGPJ1HU6HQUdWZScPIQNZJfmrlqdZgjsoHmSoD6DanZj2kY/osI9/cLOM+/XJ7Uquvmk5xMBULf1vUOjsW+P2uvO3v0xAKm6vDp4i2Fp5o9hkuNSb95KD5nJpkBJ2Hu0eHMM32/1maw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752544776; c=relaxed/simple;
	bh=SkxjcFlDaHnY+ag9EXynKDQeD9mpYPPNcWU390UpvKc=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=ti9KsnmkvYYfwVaBNYbe080kxYptJuCha9RnEtBYYMIkyB/aEAEirTJi8dLXpwKagsG3XguL6SFfmXsE6BtDZLMW8IYCCBz4V3t9y8koJ7UJv8bAet8uUYvmJkWXhmyOP9NC642uVm8iGRBbyyt/q6z7CGjykcnWEZdMVx1q7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HVnDVCOb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56F1xUkG53804570, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752544770; bh=zGfiOlPmHEbssRb1JvQiQYCEZLmX29g8WFpJDdV7mV0=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=HVnDVCObui1RHOItKW9NjdiEhviuR0AUYH4LF9skPnPUc0rkhFe1c3dZqzz8qrsgR
	 19rg0RL6U60zDVFewGwuu1cp4ChYhosMGcWDNm9cYioHj/xvgn+MPDc1l4lo4iQ9W+
	 5AFzaJZRoJEyAuhNmcKhVgAL0aX3WjRn/Rs9ch+Fvb5cYF+/eeqW03HbOnvJA4YmB5
	 zsh2iT+bLh5xdc2UPu6/pVkV3+0K0Dm257Jdcq95SrqKZng+EMdZ+nNBGJW3iJVZi3
	 FJqXuDzragZowf2uWDbGn2ByyFmGZo5ioXYu1oX8l30iiazw8Bb32QJya9uWXC6Ozb
	 Dd5ZTFFBo4HoA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56F1xUkG53804570
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 09:59:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 09:59:30 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 15 Jul
 2025 09:59:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next 01/14] wifi: rtw89: mcc: add H2C command to support different PD level in MCC
In-Reply-To: <20250710042423.73617-2-pkshih@realtek.com>
References: <20250710042423.73617-1-pkshih@realtek.com> <20250710042423.73617-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <0079b8a6-f8ab-457c-bb2a-dffb7bcbb3fe@RTEXMBS04.realtek.com.tw>
Date: Tue, 15 Jul 2025 09:59:30 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chih-Kang Chang <gary.chang@realtek.com>
> 
> Packet detection(PD) lower bound is the threshold for sensing packet,
> and it is dynamically calculated based on RSSI. In MCC, the two
> interfaces have different RSSI values, so it is necessary to set
> different values to ensure packets can be received. Therefore, add
> H2C command to let firmware to switch PD lower bound when MCC mode.
> 
> Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

14 patch(es) applied to rtw-next branch of rtw.git, thanks.

ad22869bc5a6 wifi: rtw89: mcc: add H2C command to support different PD level in MCC
9126020ab03c wifi: rtw89: add DIG suspend/resume flow when scan and connection
025e39032df5 wifi: rtw89: mcc: enlarge GO NoA duration to cover channel switching time
6332feafe37f wifi: rtw89: mcc: when MCC stop forcing to stay at GO role
d0b87d9eaf76 wifi: rtw89: extend HW scan of WiFi 7 chips for extra OP chan when concurrency
83f84f263420 wifi: rtw89: mcc: solve GO's TBTT change and TBTT too close to NoA issue
65093fab65cb wifi: rtw89: check LPS H2C command complete by C2H reg instead of done ack
5693bdd58de4 wifi: rtw89: introduce fw feature group and redefine CRASH_TRIGGER
e044f5d40f49 wifi: rtw89: update SER L2 type default value
094bb62c580d wifi: rtw89: tweak tx wake notify matching condition
868676662b08 wifi: rtw89: 8852bt: configure FW version for SCAN_OFFLOAD_EXTRA_OP feature
21911ad80512 wifi: rtw89: 8852bt: implement RFK multi-channel handling and support chanctx up to 2
504937dbaddb wifi: rtw89: 8852b: configure FW version for SCAN_OFFLOAD_EXTRA_OP feature
cefcf74ae026 wifi: rtw89: 8852b: implement RFK multi-channel handling and support chanctx up to 2

---
https://github.com/pkshih/rtw.git


