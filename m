Return-Path: <linux-wireless+bounces-14334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8939AB2F4
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 17:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68D11F25076
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 15:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D831A0B06;
	Tue, 22 Oct 2024 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AspX8KV3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDD213957E;
	Tue, 22 Oct 2024 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612738; cv=none; b=MuFJG1oF4dcLgWFc8FeBWUN9OSupnq1giMnijkahc7g+KMm89J6S6tSUpLlPFhQvJxql+BWo0+u/x1AwDsO2DOxAWZ2/elnVqibva+vZMPRKroAG9rMgNoHp3wzMGXgvXm37lbcJlkOisPweHu3a5OAthnhP5PsH5RwHoBPDejM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612738; c=relaxed/simple;
	bh=u7X7plqkp/9v6wNfXVOJrFtOm4tT8rm/aCvTWXXbSto=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=iBJ36ur4TxnIz6F/H1m7IJ5kbFCQjNctrTo0ukewWQuwFj3i0R0mKsvtd3nr92nUyaYkXeuwhKpT4bbuvTYxwRsH8E8imMBAzw+UCpkvPdwQI6a7TvvBDH7bd57RTryC9vAIk2QR2W8HYMGnSnTZF7UsY9vLro2a7OeYwyq4Bts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AspX8KV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554D6C4CEC3;
	Tue, 22 Oct 2024 15:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729612737;
	bh=u7X7plqkp/9v6wNfXVOJrFtOm4tT8rm/aCvTWXXbSto=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=AspX8KV3W7y+CPHHYvlAnMWXh8T/2zUCEqAZRcHn5f4474HiLQKiz22JIry6GiOOm
	 zsQfWc7hhNh7Ot4a0BSr8xglApKye7szdZmjpf7azWfXuXrh9P3+WQT/RayTL/J2gL
	 pnkoLzdonbb4r3KnrzhmCRPJoZKZOmQ4D1YHZgLvVsZq9fd9v4C9GCyKjOSdY0IXnK
	 gsSiT4I7cK+rFF50p7GdijoXLLrxP2GDuBcDZT/7A5GLpPnUMN0LrnZeccwcGT/TER
	 0+SpKJUCx8gWr56ELXTO8ilXenaWWZ/G40ELUuW3Z352zsd5fxY1c3rA/43lxCnJzh
	 5UvbFgJ5JlExw==
From: Kalle Valo <kvalo@kernel.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
  <quic_jjohnson@quicinc.com>,  <ath11k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] wifi: ath11k: add firmware-name device tree property
References: <20241001033053.2084360-1-quic_miaoqing@quicinc.com>
	<20241001033053.2084360-3-quic_miaoqing@quicinc.com>
	<smgbishqbin4kcpshqvue3ivvfko2l6rj2w4ikwydosbkq6kde@pdbzhklj7znm>
	<1c5f5c93-db06-4490-af2e-bbce2d184c94@quicinc.com>
Date: Tue, 22 Oct 2024 18:58:54 +0300
In-Reply-To: <1c5f5c93-db06-4490-af2e-bbce2d184c94@quicinc.com> (Miaoqing
	Pan's message of "Tue, 22 Oct 2024 18:20:50 +0800")
Message-ID: <87cyjsnn7l.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miaoqing Pan <quic_miaoqing@quicinc.com> writes:

> On 10/22/2024 5:57 PM, Dmitry Baryshkov wrote:
>> On Tue, Oct 01, 2024 at 11:30:52AM +0800, Miaoqing Pan wrote:
>>> QCA6698AQ uses different firmware/bdf/regdb with existing WCN6855
>>> firmware, which is customized for IoE platforms. And the 'pci-device-id +
>>> soc-hw-version + soc-hw-sub-version' may not be enough to identify the
>>> correct firmware directory path.
>> Why is it so? What makes it so different from the existing platforms
>> that you can not use WCN6855 firmware?
>
> Just as I said, a new customized firmware for IoE devices.

I know in Qualcomm it's common practise to fork the firmware multiple
times per project and what not, but in the community the preference is
to have one mainline branch. Having different firmware forks/branches is
a lot more difficult to maintain.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

