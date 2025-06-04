Return-Path: <linux-wireless+bounces-23670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B20CACD6B6
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 05:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12CF93A7065
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC6E2609F5;
	Wed,  4 Jun 2025 03:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscv-rocks.de header.i=@riscv-rocks.de header.b="gcCpgyMb";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="XP92K6TF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from b224-13.smtp-out.eu-central-1.amazonses.com (b224-13.smtp-out.eu-central-1.amazonses.com [69.169.224.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46723815F;
	Wed,  4 Jun 2025 03:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.169.224.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749009080; cv=none; b=JmFPnztu1FsUj+I6080i0KtqSGrb/v7togOsJZ3+qYCOZFP6aCt6koPinAa4sf+LrNETJAiv6zlplXE32TbR3AqkR1aIZBrmC1sJK82GhV7WkL4T3FXm53FyrCsUgxKXcrVmgCEoWH84uKSmZ6rgv6QEM2LrogeXzDB/dE4hCmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749009080; c=relaxed/simple;
	bh=FCX6M/oySfbIWkoHQUxk7gAuoPH1Ad0HOuqVLfG7edc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+bsutiFNhuaIa9L48TGGtS40A9g7PpMpQd6CrmzrYgul4dNy/J/R5t1xfiHdCxD3jX6JdATu3JSEyD+PTig3Pd2pu5anUOd9r2Q3XNjA0WsH+FMETe+89WZxcwaXuNAR1H/i+enlsOkPpjg405/YvFiV240nH2djJDf2bzBRZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riscv-rocks.de; spf=pass smtp.mailfrom=mail.riscv-rocks.de; dkim=pass (2048-bit key) header.d=riscv-rocks.de header.i=@riscv-rocks.de header.b=gcCpgyMb; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=XP92K6TF; arc=none smtp.client-ip=69.169.224.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riscv-rocks.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.riscv-rocks.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=2kaovp6zxy5nzp5wqunvdq5vkiqbeqln; d=riscv-rocks.de; t=1749009073;
	h=Date:From:To:Cc:Subject:Message-ID:Reply-To:References:MIME-Version:Content-Type:In-Reply-To;
	bh=FCX6M/oySfbIWkoHQUxk7gAuoPH1Ad0HOuqVLfG7edc=;
	b=gcCpgyMbVjBGaBiTGHnizUYLR5xQAZVHD6RfsJrXC8wz3qNnJNacPB/PMnNkXouU
	1+lhEh27GiuFjTF45h1X4YXhDX5WT7yBNKjedwMKviy/JvK308pc8fDp6eDs/+t/IKV
	BggoYCsMxi7u6WLsVu3X+hB8IvS+IorvqUuUHPhASikOCStz61lQwLycJiCzTpk261y
	Ko2v3n0hNxZOJjwvibHMSthynDtyomeBlBOOGaph1kQYbcIQM8Sg1i1Blsp9Et9u8qQ
	dNKhAFhpEFRAYMX/HbHclFIBzJEF2BmMUaBD2EmB+Rk0lVoB+FyBFoYmccH/H0WDH7U
	F+DCxtwcUQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=54ecsf3zk7z4mwxwwox7z7bg6e5gwjsz; d=amazonses.com; t=1749009073;
	h=Date:From:To:Cc:Subject:Message-ID:Reply-To:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
	bh=FCX6M/oySfbIWkoHQUxk7gAuoPH1Ad0HOuqVLfG7edc=;
	b=XP92K6TFLgeIB8HCydoRiZ8fRfL8bbUWW0TuhakF+b+CZMulA8YvXvNrGAQJyPQ0
	wMgvO70vu33V+h6EB20mowd71ZS7fCb2A5pvP+SLUCYPwJL0yxVpd5Wtr3jZBpJsa39
	7xM9CpFZgtTt32xLj+N/yhsdV4masEGQKdnv4m5I=
Date: Wed, 4 Jun 2025 03:51:13 +0000
From: Damian Tometzki <damian@riscv-rocks.de>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [wireless] WARNING in iwl_mvm_sta_rx_agg+0x9d3/0xb70 [iwlmvm]
Message-ID: <01070197391084ce-d98dad57-8c40-4b6a-bf8d-bcea74a8e019-000000@eu-central-1.amazonses.com>
Reply-To: Damian Tometzki <damian@riscv-rocks.de>
Mail-Followup-To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0107019736e3a599-79e58a4a-0dfa-4f43-aeaf-4a4208845b32-000000@eu-central-1.amazonses.com>
 <DM3PPF63A6024A98E210FB9D166A3CD1316A36DA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <CAL=B37=-q=Veghr7bo2GGiy1eyKP_xF0g8SeK5Lu6uKTVZgxoQ@mail.gmail.com>
 <DM3PPF63A6024A97BAB8D43C0FAEB7078BCA36DA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PPF63A6024A97BAB8D43C0FAEB7078BCA36DA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
User-Agent: Mutt
X-Operating-System: Linux Fedora release 42 (Adams) (Kernel 6.15.0)
Organization: Linux hacker
Feedback-ID: ::1.eu-central-1.yMcBPu/jK26Vj3HVmCFyFk75QMsS8V3QY5HbXP/Qrys=:AmazonSES
X-SES-Outgoing: 2025.06.04-69.169.224.13

On Tue, 03. Jun 18:22, Korenblit, Miriam Rachel wrote:
> > If you need a kernel trace, I can provide a trace-cmd log. Please confirm which
> > events are relevant ?
> > My idee ?
> > sudo trace-cmd record -e mac80211 -e cfg80211
> 
> trace-cmd record  -T -e cfg80211 -e mac80211 -e iwlwifi_ucode  -e iwlwifi -e console -e iwlwifi_msg -e mac80211_msg 
> 
Hi together,

perfect, the patchset resolved my issue:
https://lore.kernel.org/linux-wireless/20250604031321.2277481-1-miriam.rachel.korenblit@intel.com

Many thanks
-- 
VG
Damian Tometzki

