Return-Path: <linux-wireless+bounces-4088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CB08691A6
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 14:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA8428D299
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 13:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099FD1332A7;
	Tue, 27 Feb 2024 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnjpRWG1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA46E13A87C
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040184; cv=none; b=lGCd0jzvSmTCt/vvomZN1P37qZx5wvGB4Q6Fk9SoUYSD4Y4YsrwNX6NNbFeiX1jGC/PxEozvOMSA+WzEm5U+s6e4NGVghPLagmI+CGA6oqLVXB/9XMN013DE4f693/9n7vTA/v/8W2ob4wAFi7+uoFah4x//PMVAkEOM+k0A1+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040184; c=relaxed/simple;
	bh=TUkZkkUGbM11amjg6L2bFOhq4Ad1EaBH2oZivW9MLj8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=V72qD9rCI9NE28JpVDuRqG0NVyHk8hrnNW9GpzHWGyxP+cdK5SQV04ZNDiC+COJYVPwJgszn4YNePZDGpwLey9HDyg6/lHTjaQ+a/UeBMhiveVmjRexkpw7drp3HVGgWXx3HRM3MyA+vD5v6MLnffmIc8qKYppMu70UURftQBtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnjpRWG1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A887AC433C7;
	Tue, 27 Feb 2024 13:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709040184;
	bh=TUkZkkUGbM11amjg6L2bFOhq4Ad1EaBH2oZivW9MLj8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=qnjpRWG10Z1GRIM7uPI78mrinLBuTcKaqqj4xGZY0OLDrQKXbSZy8od7d2L2LEfqX
	 K3n2hFb7Sl59E4Yb3v6D906va6CnV//7I1EE1PT1EbqKLQWSNk6PNOsbqUtgqKcWIr
	 OwwRQbcWNaaSf228gp3jggrQg3Q1uN/56W72Wc2FpzGtft68Yegp3MBFOql2hB/Ix3
	 5ipAMT0XpA3WXTpEI4JF3IHhQoKrimhQHod6me4IlIP+24fHbvT4UZXcqF/oubB8T1
	 LVP0CyhQDcjQDvLWp6l4+wfNR+bNZRqRvZD47Li33tcsIGhHERlbLoQtZH3PnS92a2
	 JAlHMO8sv/ukA==
From: Kalle Valo <kvalo@kernel.org>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4] wifi: ath12k: report tx bitrate for iw dev xxx
 station dump
References: <20240219095802.1147-1-quic_lingbok@quicinc.com>
	<87y1b7jkxu.fsf@kernel.org>
	<6f39eb1c-97f7-4029-a5f2-5ab36ff0f0a6@quicinc.com>
Date: Tue, 27 Feb 2024 15:23:01 +0200
In-Reply-To: <6f39eb1c-97f7-4029-a5f2-5ab36ff0f0a6@quicinc.com> (Lingbo Kong's
	message of "Tue, 27 Feb 2024 21:07:36 +0800")
Message-ID: <877ciq9h3e.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lingbo Kong <quic_lingbok@quicinc.com> writes:

> On 2024/2/26 23:37, Kalle Valo wrote:
>> Lingbo Kong <quic_lingbok@quicinc.com> writes:
>> 
>>> The tx bitrate of "iw dev xxx station dump" always show an invalid value
>>> "tx bitrate: 6.0MBit/s".
>>>
>>> To address this issue, parse the tx complete report from firmware and
>>> indicate the tx rate to mac80211.
>>>
>>> After that, "iw dev xxx station dump" show the correct tx bitrate such as:
>>> tx bitrate: 104.0 MBit/s MCS 13
>>> tx bitrate: 144.4 MBit/s MCS 15 short GI
>>> tx bitrate: 626.9 MBit/s 80MHz HE-MCS 6 HE-NSS 2 HE-GI 0 HE-DCM 0
>>> tx bitrate: 1921.5 MBit/s 160MHz HE-MCS 9 HE-NSS 2 HE-GI 0 HE-DCM 0
>>>
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>> Tested-on: QCN9274 hw2.0 PCI QCN9274 hw2.0 PCI
>>> WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
>> Please use full englist words like transmit instead of tx. Also the
>> title could be simplified to:
>> wifi: ath12k: report station mode transmit rate to user space
>> Here I assumed this only works in station mode. Or does this also
>> support AP and P2P mode? The commit message should explain that.
>> 
>
> Ok, i will apply it in next version. Thanks for pointing out.

After rereading my comments maybe keep the title simple like:

  wifi: ath12k: report station mode transmit rate

But it would be good to clarify in the commit message what modes this is
supported. And what hardware families support this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

