Return-Path: <linux-wireless+bounces-1890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC6882D112
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jan 2024 16:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0110828222C
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jan 2024 15:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986FA523D;
	Sun, 14 Jan 2024 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dffpTODq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2057E
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jan 2024 15:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1863C433F1;
	Sun, 14 Jan 2024 15:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705244986;
	bh=KonVwvysHSEyFJbAjmUrw7TyfJrPr/NzwAPENtus/EA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=dffpTODqOU1KwpxGdKP+9C7E1MKQ/ZTW8B5SxTSMpeDocSxUTih+LLZWsYBedL1C4
	 y29rroLqpHLE7E7W7KRL+TWjVIFpALLQb/sa+zwZZqaEtsTjAVZssYc95BFH+OipWC
	 3IPdCzrqc1ZeU9gywp9p5luxqBfd4LDnY6TdQlucEBJ90tsjIcfwMdCsc0Xw1nvpnI
	 Q2r/DtYPZLxGuoW+4yORkTKR8xF+kf1IsZs4bU+dbF3lcnr2CzXwjsrGcjtOcVR7Ga
	 t/oyLUU3yYZSu35h3dfNYVH861ebw6eoP4DSP24GXcF9GzVi2yZwIlEtdK4hYf6/lL
	 f+7VDUbuik0UA==
From: Kalle Valo <kvalo@kernel.org>
To: benjamin@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,  lenb@kernel.org,  Benjamin Berg
 <benjamin.berg@intel.com>,  ath11k@lists.infradead.org
Subject: Re: [PATCH] wifi: ath11k: rely on mac80211 debugfs handling for vif
References: <20240111170629.1257217-1-benjamin@sipsolutions.net>
	<877ckfip1g.fsf@kernel.org>
Date: Sun, 14 Jan 2024 17:09:42 +0200
In-Reply-To: <877ckfip1g.fsf@kernel.org> (Kalle Valo's message of "Thu, 11 Jan
	2024 22:38:19 +0200")
Message-ID: <87a5p87xzd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> benjamin@sipsolutions.net writes:
>
>> From: Benjamin Berg <benjamin.berg@intel.com>
>>
>> mac80211 started to delete debugfs entries in certain cases, causing a
>> conflict between ath11k also trying to delete them later on.

Instead of calling it a conflict I would prefer to clearly document that
ath11k was crashing so badly that it was unusable.

>>
>> Fixes: 0a3d898ee9a8 ("wifi: mac80211: add/remove driver debugfs entries as appropriate")
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218364

s/Bugzilla:/Closes:/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

