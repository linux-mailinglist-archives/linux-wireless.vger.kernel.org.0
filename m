Return-Path: <linux-wireless+bounces-11292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABD194E756
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 09:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94B61F20EE5
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 07:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956EC482DB;
	Mon, 12 Aug 2024 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1GvsBRn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1082B2DA
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723446146; cv=none; b=ruBnm0nsZO2j6dxY8nXEOCWEe+nLR7T6hvxHlkPGragXgWvCNL9wfEBd/XY/70NqcLk3pxCV54YuKsD9Y9Y39V29XC9GAQvY0f8iHEDxZbo9vYlDhCn+aVvqZ++YWroOCbkCXiP+e//bzXdYcixFerdmHpJIqT3/FvnPU6zJsZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723446146; c=relaxed/simple;
	bh=Q1we+g2Kf82ebRmd2zdBaMIkKNXc+TJk3q2/rStIRns=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=GIBlwP02jVRC2H9cTV/Jwb91aTKrKkAoWJK8hfTmHw/EOPunhuXJCQXTXPTtMuTPVDMEEK163k8Kjk3B/85w5Ws0rrKBjof+NRlkW4QuSOoxFR4PWwrPILZWFalsQFV9xBXidTEK6xw/XQrTQ5CzBOhfm19nNBPkFUocoJq966k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1GvsBRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15464C32782;
	Mon, 12 Aug 2024 07:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723446145;
	bh=Q1we+g2Kf82ebRmd2zdBaMIkKNXc+TJk3q2/rStIRns=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=R1GvsBRnpcV8k2myB630F3uY/KrDzzfy4UNI1u+sLoT3m5rjv3XHJaChGO5wB5XWc
	 pzUJ6cwyGNgUA7n08/iYNUpDio7vmxtQ9W71Sdb+gO1K3tid2h0RhdkdCdOzatTsXe
	 3+xEhwweiK2QTZe0FI7wImAp0CTIYVY7F75/NnkIh7MmQGyGyXX5JGmKmNXQ2f+Gge
	 XYcog4zC7dhFGuR3DaUnjHPsROZkGlICve3fbRF7QF1oxYWQtonO/UOKzAfn6LeXGN
	 5cfIERNVhGxbty/TxY0WyaLA+5k0mLacLN0tTbvjVaryt+CP9FtkKLDgNfMgmvZDqe
	 KqDjQ3DNf2yNQ==
From: Kalle Valo <kvalo@kernel.org>
To: MOHAMMAD RASIM <mohammad.rasim96@gmail.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [question] is it possible to enable monitor mode /packet
 injection on wcn3990
References: <CACq04CG8WCGDxf6Krx3bjxHU5OtYJJNOtD77TtPQhTfdy6ey_g@mail.gmail.com>
	<56BBE89F-FF40-47C4-A4B9-F492FD8F6E2A@gmail.com>
Date: Mon, 12 Aug 2024 10:02:22 +0300
In-Reply-To: <56BBE89F-FF40-47C4-A4B9-F492FD8F6E2A@gmail.com> (MOHAMMAD
	RASIM's message of "Sun, 11 Aug 2024 20:30:51 +0300")
Message-ID: <87zfpigr5t.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

+ ath10k list

> I have a device that has the wcn3990 wifi chip that uses the
> ath10k_snoc driver, i tried to put it in monitor mode, the "set
> monitor" mode command succeed but can't get any scanning working after
> that, does the chip support such mode?has anyone tried monitor mode
> with this chip or other snoc chips?

I doubt that WCN3990 firmware supports monitor mode, though just
guessing here.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

