Return-Path: <linux-wireless+bounces-173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1F77FC432
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 20:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D26CB21483
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 19:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0467246BB9;
	Tue, 28 Nov 2023 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=galax.is header.i=@galax.is header.b="01m3OCgm"
X-Original-To: linux-wireless@vger.kernel.org
X-Greylist: delayed 5672 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Nov 2023 11:22:18 PST
Received: from mail2.galax.is (ns2.galax.is [185.101.96.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDAA10EC
	for <linux-wireless@vger.kernel.org>; Tue, 28 Nov 2023 11:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=galax.is; s=default;
	t=1701193663; bh=4cqVZWV6RE8i9nLlOrg74KF/NCWPLfwhhDpREzj45/0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=01m3OCgm1kWlnXsYMYcqvIrtgczSEi+0zTs63l2lagFPC6OlsJa25KJllMyQBQqf7
	 EuGHSsQcJRnBVod9hESN/HRwodNDS10QWvpPmWPKOdMELCk/UKyBrQuxRWRNFmD0WY
	 XfQEbvf0JVDgcVA2f8anhBKtb3OCGWMajU9ZXI8Krs62AwEpNkIi63NLLVGRzPd9Hy
	 oQvfXKrxgAHPIKF9HoBrShiyUiDibyFNonr1jftbCRnJJkoMMbwxqGQR3b3ybZVC6/
	 2mbB2LzAX0/Nioutyrw39VQs5017MtZINwWOZa4YWtdmzUWRErv58/ZaB55yHP60FF
	 QvLmz/v17VJFw==
Received: from [IPV6:2001:16b8:5704:e00:fd93:2166:5759:eabf] (unknown [IPv6:2001:16b8:5704:e00:fd93:2166:5759:eabf])
	by mail2.galax.is (Postfix) with ESMTPSA id 5B81B1FF1E;
	Tue, 28 Nov 2023 18:47:43 +0100 (CET)
Message-ID: <31cd6c6a-7c0d-4fe3-832d-603afe0125e9@galax.is>
Date: Tue, 28 Nov 2023 18:47:42 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michael Krause <mk-linuxwireless@galax.is>
Subject: Re: [RFC PATCH] wifi: cfg80211: fix CQM for non-range use
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20231106231715.3a506ac2dadb.Ie774b85b9d4ff934a1236e77096cb9c6c9fe6561@changeid>
Content-Language: de-LU, en-US
In-Reply-To: <20231106231715.3a506ac2dadb.Ie774b85b9d4ff934a1236e77096cb9c6c9fe6561@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Johannes,

You are probably aware of this already, but I believe this patch is quite crucial as your earlier patch may have effectively broken some roaming scenarios using wpa_supplicant.

The supplicant is using CQM to monitor for RSSI threshold changes (non-ranged) to switch between short (few seconds) and very long (1 *hour* in the default NetworkManager setting) background scan intervals. With a current lts kernel (6.1.63) on Arch I do not see RSSI change events at all and wpa_supplicant will almost never (1 hour timeout) scan for a better AP as long as the current AP is still in range.

I applied your patch against 6.1.63 with some additional `goto unlock`s and it resolves the issue for me. I've been running the kernel for 2 days now.

cheers,
Michael

