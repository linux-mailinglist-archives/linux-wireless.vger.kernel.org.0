Return-Path: <linux-wireless+bounces-15694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B43689D8ADB
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 18:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09542825DC
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 17:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBD11B413D;
	Mon, 25 Nov 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjmMEjAN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF941B4131
	for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2024 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554030; cv=none; b=aqf7olr0ThS+JpKcQ16rO1DCagjTDgZNhJriWjZCcoMhpKZbbuGK+DzMrgh6U61AhxUePnecJXoRKMrDwYWr3QfwnmydxTgnKFhbbDnqixEzG1nOqMT/BsBLXeCM4Ihp5ZPtOr9AcLUAfgyuEffTPWkRYv1mmTlTQh7/PVT3XXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554030; c=relaxed/simple;
	bh=ZpdtgCOvC2vYFV3iJbB+pzmCQ15Uvkhci3/MOAeUb3Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=QZoIKIpz0zr+PQlCFvTPGacad901bIzdYF4WKSdxdLoc9NYU9MniXa67xHWEvaZQPAOpP4chYuJ6HXPMb15R8ym7Ixs8L40MUIPc+fA8sQS1lv4S+NV3kKLjSSDz20QUIWd4sfIBt83IEHpuvPXb5F8iR92a+Rmphrr02N5rZbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjmMEjAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B54C4CECE;
	Mon, 25 Nov 2024 17:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732554029;
	bh=ZpdtgCOvC2vYFV3iJbB+pzmCQ15Uvkhci3/MOAeUb3Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=pjmMEjANOc5F3JWy4dOwfVC0OKg2xAJfDJXJWFB6sVfzyckH+SxHsqxxiIruv0EPT
	 lycmuNKmj1pxIBvzZ0aAlgqh9USEpyze2YYjWRRsGWECigMWjl+dJuL6AFCAtQLlSh
	 szflwxQI3Q15DMMsctMw+RRo/e/m+WGMZix+qfHRUepfv0uy68SktEIKb0JZKO5oTJ
	 R1QUecEDYNIQpDOfk/jYr947Ew7JwIF/E/hdA5rfstWuTZevcr7LQZV3IbjAqEmT7v
	 Ye9fAFUVZzATre9JpqRpwqWMBtEz5vDeDwd8/cKZ7ua7OMs3hukjRFX2owpz8yOLZU
	 DIKx4sq4OPVBQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 0/8] [0/8] wifi: ath12k: MLO support part 3
References: <20241121155806.1862733-1-kvalo@kernel.org>
	<43157125-9cc4-4312-8005-05bcc670b89c@quicinc.com>
Date: Mon, 25 Nov 2024 19:00:27 +0200
In-Reply-To: <43157125-9cc4-4312-8005-05bcc670b89c@quicinc.com> (Jeff
	Johnson's message of "Thu, 21 Nov 2024 09:01:32 -0800")
Message-ID: <877c8rw8no.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 11/21/2024 7:57 AM, Kalle Valo wrote:
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>> 
>> We continue refactoring ath12k in preparation for supporting Multi-Link
>> Operation. For example, in this patchset we modify station state handling and
>> start to use more link level configuration.
>> 
>> Please review.
>> 
>> v2:
>
> FYI "v2" wasn't captured in the subject, but please don't resend due to this :)

Oh, sorry about that. I forgot to add that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

