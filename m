Return-Path: <linux-wireless+bounces-15204-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BE09C5B34
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 16:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16945281308
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 15:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF09A201276;
	Tue, 12 Nov 2024 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCshjeoy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9704720011F;
	Tue, 12 Nov 2024 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423546; cv=none; b=R+tqJEHeYWqlCS3DLrvbf63mh1E11ecgmLbqLhUTHxU+2ZcMy+pJoZRycRAnRd/3Eh0hUmIOiig0Vl6yN4LgDxrDKmRbHzn6DtNiMs3Ga6L8YEnO8frswy3cChNJRVPs5uUkRGhGQE4AmIVALd9NYKy1xOQwfTTcXsPHzdusaf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423546; c=relaxed/simple;
	bh=DpsWLJxtohQJudxgWo/V7PQCzAkmAY48E5oG2OuDKmo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=MUgFO8d46a7OlZBWcHPL3+v+GqgmAr/1hxFt+Jm3wbH6kcf6UhpWEVELrjFHo2zYQJL/vvu01dbQNaukpio8XTb/8OQ4ggnAnNwAaAiqBE7mH90vtgTdifr8v8zD7T4qzNqWdzxpjFeD59N5hdrzFkaqRLHXEnDwWXmxsY47z+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCshjeoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA7EC4CECD;
	Tue, 12 Nov 2024 14:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423546;
	bh=DpsWLJxtohQJudxgWo/V7PQCzAkmAY48E5oG2OuDKmo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=RCshjeoyuwM7Ojxw0bPmH++yRLgJ26P7Wvhx9yYlTWvW8W+bLZoX2imjVLgBxnDcZ
	 LGtXQB07WTs+77RVdXCjW3yBuWsJ+UkQveevGNzSGKgJYVdjcRzjayDmbgfKKCGXrl
	 RnJMMYQNBDbC8so7O/SLc0VNkmeUDocgeLWvgZFBskqzbE6FGipM5SlrhGY1SKbe2r
	 Z5MQi8WyFI0zWIXQbHGgncM51EVaYxEtcifejjYhKRr39v4VUT4NGbDBekvbxBGBr/
	 euuhNHbwuewtf9jBN6sevXh+tPHWFpecj5BW9L5jqJ9w7uO/jvygp4ZL6Oiy1m00Fp
	 9ji/0/uIBVdGw==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,  <ath11k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath11k: add support for QCA6698AQ
References: <20241031000541.3331606-1-quic_miaoqing@quicinc.com>
	<bb1c77cb-7efc-4c85-a946-5394b9105416@quicinc.com>
Date: Tue, 12 Nov 2024 16:59:03 +0200
In-Reply-To: <bb1c77cb-7efc-4c85-a946-5394b9105416@quicinc.com> (Jeff
	Johnson's message of "Thu, 31 Oct 2024 07:58:56 -0700")
Message-ID: <87o72k4hxk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 10/30/2024 5:05 PM, Miaoqing Pan wrote:
>> QCA6698AQ IP core is the same as WCN6855 hw2.1, they share the same
>> PCI device ID, the same major and minor version numbers, the same
>> register address, and same HAL descriptors, etc. The most significant
>> difference is that QCA6698AQ has different RF, IPA, thermal, etc.
>> 
>> Follow the approach done in commit 5dc9d1a55e95 ("wifi: ath11k: add
>> support for QCA2066"), enumerate the subversion number to identify the
>> specific card.
>> 
>> Tested-on: QCA6698AQ hw2.1 PCI WLAN.HSP.1.1-04479-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
>> 
>> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
>
> Am I correct that this satisfies at least a subset of the devices you were
> trying to support with the following?
> https://lore.kernel.org/all/20241024002514.92290-1-quic_miaoqing@quicinc.com/
>
> If so, can you reply to that thread, pointing to this new patch, and elaborate
> on what is now supported and what still requires ath11k to support
> board-specific firmware overrides?

That question is still open but otherwise this patch looks good to me.
But I'll give an Acked-by only after I understand what's that "NFA765
m.2 card for IoT platforms" mentioned in the other thread is.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

