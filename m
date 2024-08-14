Return-Path: <linux-wireless+bounces-11392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAACF951367
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 06:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1246B1C2101D
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 04:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510F03987B;
	Wed, 14 Aug 2024 04:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikOgzmM7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0CD347A2
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 04:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723609023; cv=none; b=WJcGzBPjj5XwPVVrbxkAOAAnGPzW8bxc9v1LGEg8gPxMBnbOGjpwnzesj18P8s71ZOlj98ih7bqHnhQfvTe4LltQF9Xui4xEun4km6L5UgoFzT41VGCUqVU2Auk24ThWd4PaLrqxwFCPnEWrsBo6rIh8mGauqwiN0wxatsMBLBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723609023; c=relaxed/simple;
	bh=P66EC/EOWgTS3MmgKmRne8BgZ5jFbuBCFQ1xi7keYQk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TZCIbVUMy5TOtp6ARqGW4lUyo5YjqZQFHy98FUgQIoAnJ4YvkHxebFw8msRvYixINobUjbM1go6Tkp0/xncVMlMO9R58jQ4eJUGzJ793OvdbhQbe3jeqb/IuWepJa6hJ8Qa8/sTf8xkoWNVvHL4nvtqkvYpjOlT8158IiGa/zJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikOgzmM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1692C32786;
	Wed, 14 Aug 2024 04:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723609023;
	bh=P66EC/EOWgTS3MmgKmRne8BgZ5jFbuBCFQ1xi7keYQk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ikOgzmM7M+GwqXsBFTaSWUCI8dyJh7on+m31Uqme2/hci1Jhay3sNxrAYOLVwUEzN
	 gQd6cGTgC1owfWZggAbxq4uWCrFlmtMbXsxFXgz4lhA9rEyKl/b24xeC1LaZzVPzSM
	 bKNy9nIkLko7Uf1aHMN2vmwgb6r/WBW1j+94fB9FIJqWABhNK1TI8xh7INulcjjDhl
	 8bl3scrldbGU2t2oX/y5oFIEJNZ3disyfGi0u5x6TGh5sKyW3CzXjVZ/jVBAJ4+Pvo
	 u2k/bKUrV+V7wfBR8NFjEHQUbSTNdOu5DorEfbI6uLNTuNriD8mu5ht/LwXy1MdW5w
	 YqLWJ0f28VZ9g==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id E507B5FCA8;
	Wed, 14 Aug 2024 12:16:57 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240813-workflow-v2-0-6d8039283d45@flygoat.com>
References: <20240813-workflow-v2-0-6d8039283d45@flygoat.com>
Subject: Re: [PATCH v2 0/2] wireless-regdb: Workflow updates
Message-Id: <172360901791.1747049.9173998849926904492.b4-ty@kernel.org>
Date: Wed, 14 Aug 2024 12:16:57 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 13 Aug 2024 20:39:38 +0100, Jiaxun Yang wrote:
> This series updated some workflow components to streamline
> wireless-regdb contributor experiences.
> 
> Please review.
> 
> Thanks
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/2] wireless-regdb: Update .gitignore
      https://git.kernel.org/wens/wireless-regdb/c/3afe17272b35
[2/2] wireless-regdb: Add .b4-config
      https://git.kernel.org/wens/wireless-regdb/c/bf55ed481432

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


