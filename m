Return-Path: <linux-wireless+bounces-4337-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9660C8704C0
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 16:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B9C1C21215
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 15:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52FD45945;
	Mon,  4 Mar 2024 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpyT2ep5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6103F9C0
	for <linux-wireless@vger.kernel.org>; Mon,  4 Mar 2024 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564625; cv=none; b=tXSO+UGwu+k/vNtLjuMfbNsWxYG3L24XNIr5xXxq+/7emMJRmo5UdtrI16R7J3zL7B3UMvzoYv4B8gQbvggHohTDg3haiw2kOtFfTky3XpyL1QN3d9WBw0xhXoeXlF2Yh51Vx8EVMYnvWF/SozLcOJuY9EO/6FiNAWfUZbYEkw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564625; c=relaxed/simple;
	bh=WQGQ27mX80efnKaDnp/B9HWNqMMcFRihUMuvEC5ETXw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=uCmz29e2CUq5BBzNdh6EkYtmGJ7BOIY4bOo/M/OnZDRwY/JFRjT1t3q9arTH8fAmFUZj7EzBbxYq+k8/zY1Jsgk5y81cMKrGdZ+IG3joUlX604M+5dWFffdT5QqMgvPlnKexK9KIZ7yzm0A1YuAk0nqeZYOcWeUSJENRxa29zQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpyT2ep5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E269C433F1;
	Mon,  4 Mar 2024 15:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709564625;
	bh=WQGQ27mX80efnKaDnp/B9HWNqMMcFRihUMuvEC5ETXw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=IpyT2ep5fKlrHz1Zwj6I79qS47B2R0XE7lpq2xOWh6z/sKpZ0yRfm9d6VYUQplSre
	 jtdSu6U40ELisDVIkA6t94GrR32aWR3TR99IR6Msenoenuisy2otjFsrSihJUoMLlG
	 +6rM7smsnvbDa3Wg/8L6MWSF/yH19nPigciAKAYvWh+WUzgtvabRmBxcet2W1cBojE
	 Pu4Ujs/77Ptl8H4dEuHEA8nj3PMfuEAp8T0X8b2RBXguufMB2KLM1BkZdN16Weri3B
	 zfk1HVwPbRHRftxVED8TEMq4D7OmIgO80Y9LDMP4O4zcCAGjzybuGI5+8R4mGn5FuU
	 hzKcDE7fsrAGg==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,  Ilan Peer <ilan.peer@intel.com>,
  Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: Re: [PATCH] wifi: mac80211: Adjust CQM handling for MLO
References: <20240228094753.bf6a3fefe553.Id738810b73e1087e01d5885508b70a3631707627@changeid>
Date: Mon, 04 Mar 2024 17:03:40 +0200
In-Reply-To: <20240228094753.bf6a3fefe553.Id738810b73e1087e01d5885508b70a3631707627@changeid>
	(Johannes Berg's message of "Wed, 28 Feb 2024 09:47:54 +0100")
Message-ID: <8734t682er.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Ilan Peer <ilan.peer@intel.com>
>
> The CQM handling did not consider the MLO case and thus notified
> a not-existing link with the CQM change. To fix this, propagate
> the CQM notification to all the active links (handling both the
> non-MLO and MLO cases).
>
> TODO: this currently propagates the same configuration to all
> links regardless of the band. This might not be the correct
> approach as different links might need to be configured with
> different values.

Is that TODO link there intentionally?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

