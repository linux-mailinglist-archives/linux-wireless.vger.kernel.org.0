Return-Path: <linux-wireless+bounces-2299-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5074083561C
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jan 2024 15:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83DBE1C20FB2
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jan 2024 14:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04D614F7F;
	Sun, 21 Jan 2024 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="XJBCxUEE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6CF12E7C
	for <linux-wireless@vger.kernel.org>; Sun, 21 Jan 2024 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705847610; cv=none; b=Eu1X4ApfXr+s6Cg0O0pJMrSI71b+1SfdcwFwb6WWtpVOZljNubyF1wr+vWJqwkfUoHYYzinvw8SABodvUNr8IELKiWsAel/lldjVwXrsipoiD/ZJVq6WXoPBW+7EmXpB8xde4eoWLphikK5JS/OBpgoRkck4DA/7eTzr4tpObys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705847610; c=relaxed/simple;
	bh=CEsQHYGJOftxpDIrWcLlvP3iwYb+8m2Oxm/xnQXhAZ8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=HgD31gmyU4ds9QCQZrxKz2A/sasqbwkTi7HxYgLYa+VvbcLGxhLgqGtoGVUWrKl1hgFicpNAww3FOxhtFtzWxFK/rAVbF3NCEJdpZczjl982DjZl+Iz291jYwqwCvPhUOtMOR4f8gezIUZ4qMczKzG9P5bRexqJNo36KWT9BCYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=XJBCxUEE; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 13C1250078D
	for <linux-wireless@vger.kernel.org>; Sun, 21 Jan 2024 14:23:26 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 118242C006C
	for <linux-wireless@vger.kernel.org>; Sun, 21 Jan 2024 14:23:17 +0000 (UTC)
Received: from [192.168.22.29] (unknown [50.225.254.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 4385513C2B0
	for <linux-wireless@vger.kernel.org>; Sun, 21 Jan 2024 06:23:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4385513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1705846995;
	bh=CEsQHYGJOftxpDIrWcLlvP3iwYb+8m2Oxm/xnQXhAZ8=;
	h=Date:To:From:Subject:From;
	b=XJBCxUEEYUgLhT62FT9wlvhKnUc6fzwzIK1beX8YzDlTPVcKrfoxPcIU0H+4wldTR
	 ByvD+R5DBxZ1pzWGqAvq1qCycUAD9yegld7ABBlajqzVoKZV+B7HEtg+GCVd/k8zoJ
	 I9yuiDecf24i8xveIjYVPlm9D2KBo+ulI3hTZ/kk=
Message-ID: <3268b287-afe6-3df6-7bde-cc244d1d81d2@candelatech.com>
Date: Sun, 21 Jan 2024 06:23:14 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-MW
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Subject: mt7915 bss color question
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1705846998-HDcVe-eab1Zn
X-MDID-O:
 us5;at1;1705846998;HDcVe-eab1Zn;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

I'm curious if the code below (and nevermind that dev_dbg I added)
should also check the omac_idx for STATION type, since it is possible
to have lots of stations on an mt7915 radio?

static void
mt7915_update_bss_color(struct ieee80211_hw *hw,
			struct ieee80211_vif *vif,
			struct cfg80211_he_bss_color *bss_color)
{
	struct mt7915_dev *dev = mt7915_hw_dev(hw);

	switch (vif->type) {
	case NL80211_IFTYPE_AP: {
		struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;

		if (mvif->mt76.omac_idx > HW_BSSID_MAX) {
			dev_dbg(dev->mt76.dev,
				"update-bss-color, omac idx: %d > HW_BSSID_MAX: %d, bss color NOT updated.\n",
				mvif->mt76.omac_idx, HW_BSSID_MAX);
			return;
		}
		fallthrough;
	}
	case NL80211_IFTYPE_STATION:
		mt7915_mcu_update_bss_color(dev, vif, bss_color);
		break;
	default:
		break;
	}
}

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

