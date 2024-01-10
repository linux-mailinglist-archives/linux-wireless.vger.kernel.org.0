Return-Path: <linux-wireless+bounces-1653-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FB7829691
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 10:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B790228373D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 09:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F313FE28;
	Wed, 10 Jan 2024 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDhxxxTp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA34C3FE29
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 09:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D48C433F1;
	Wed, 10 Jan 2024 09:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704880148;
	bh=u4/mRWQFGYRhFE1WCHb571aho0C+PEsnid9U4Zq+ys8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=mDhxxxTpY+pBz0/ETS0o53OssdStzHXes1XziXHhqEDtVGk/PM9lDpUUx38l5n1s+
	 G/z06jdNjC6Ugg6iDpG51+2qqMB4XN/EFNhZTM7vu7EuuEA2EY8lCrLsNOEuiCHd6t
	 ysf07vfcgMVs4qszaLdcIune0rkKXystda2hl84YGSJeRULCnmO863bKO2VfaTm8Tn
	 IrqVbDylOjM6ZBG6D7AsqH65xEv4iFEmPpOjDGFmIK/F/WHtY01jrYNCSQ6mS+6qzc
	 cG0nSpr5XgUelgYpaf2ivt9Q9u11QhqfBDynnqXh7tJoZ0cEa0duNuvvmRpJACsE+8
	 0zTSJka7hrcOA==
From: Kalle Valo <kvalo@kernel.org>
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
Cc: <nbd@nbd.name>,  <lorenzo@kernel.org>,  <deren.wu@mediatek.com>,
  <Sean.Wang@mediatek.com>,  <Soul.Huang@mediatek.com>,
  <Leon.Yen@mediatek.com>,  <Eric-SY.Chang@mediatek.com>,
  <km.lin@mediatek.com>,  <robin.chiu@mediatek.com>,
  <ch.yeh@mediatek.com>,  <posh.sun@mediatek.com>,
  <Quan.Zhou@mediatek.com>,  <Ryder.Lee@mediatek.com>,
  <Shayne.Chen@mediatek.com>,  <linux-wireless@vger.kernel.org>,
  <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2] wifi: mt76: mt7925: fix the wrong data type for scan
 command
References: <20240104113206.13252-1-mingyen.hsieh@mediatek.com>
Date: Wed, 10 Jan 2024 11:49:03 +0200
In-Reply-To: <20240104113206.13252-1-mingyen.hsieh@mediatek.com> (Mingyen
	Hsieh's message of "Thu, 4 Jan 2024 19:32:06 +0800")
Message-ID: <87y1cxy0vk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mingyen Hsieh <mingyen.hsieh@mediatek.com> writes:

> From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
>
> For the member of 'struct scan_req_tlv', replace data type of
> func_mask_ext from 'u8' to '__le32'.
>
> Change-Id: Ib9fc1aadd1f1960b63d35f31f0a4655416884bf0
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

We don't use Change-Id tags in kernel.org.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

