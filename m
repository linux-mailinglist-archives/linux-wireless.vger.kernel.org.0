Return-Path: <linux-wireless+bounces-11731-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAD7959858
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 12:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C7F1C20833
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 10:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174861A7ADD;
	Wed, 21 Aug 2024 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmjS/NgT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FDE1A7AD5
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230910; cv=none; b=RbQacJhjhPhGKOU4HQ0HCSYl0xXewCXEiVIyXJ3xmUOgzj0kkNJTT/HwKNDlJ32B5nplOKzYFWEMyQ1n92uYZdokysy4tXOSxmGuU6vXgzyTDcVGKfoFoPSZlCXvQSrwx6CEQMjVWzUZUSXNen+fw4jcQ3rvwCO9p1dVOZ0JqDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230910; c=relaxed/simple;
	bh=maG7etaY+QFxAFyDGBYNFOqUIPV+e1BhdKSc6jAtAEk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BN0uUwP2Mg5IaqUXWUBMJz3jYAt9wG++QsngK/x30Vt7YwIJNgeOdj1tGabdN7t819bHW4Od3+D6homQyET2pXMWv/hjOcijiNXRMa4q73J5SDxodK6S2XNFXMp9xOsUj+8hazy48q/2Rhd9rWh9hH1FRq8Wg0FkXkqqQxhiPY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmjS/NgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2363FC32782
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 09:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724230909;
	bh=maG7etaY+QFxAFyDGBYNFOqUIPV+e1BhdKSc6jAtAEk=;
	h=From:To:Subject:Date:From;
	b=GmjS/NgTDKvfe0v4Xr7ScGS+p8q7R+Mtfyp05Pypk4M2i89BaUTsV3M1oU3DxeejW
	 4/UkTTxmtQ8yj6fhFjDaFSSqa7+VhDtwRa3hg/4/Vgb9zigAirNIFi0YYFF5n/oH0G
	 3hSR1vl2j3hYyFZ+73RKVgYX8C2oc8EuVplULWRtJuFU0fi8R9q1VdA5Ya+aeRseIE
	 z+s8gi8sp7pUQylDNj8qJHeD9frgQiD0aW3GjRJ+HNtvHDOqzuUV2PcFycQlZpuY04
	 WaUxzEKxLUTElFzby1LiJxwLowRnoGa8gWp8LGQjOF+q91p58c6w0Q9/hA/37Mgn6i
	 RWu0MrnUTuhBg==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Subject: wireless-next v6.12 deadline September 9th
Date: Wed, 21 Aug 2024 12:01:47 +0300
Message-ID: <87frqyw8p0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

As net-next might close earlier than normal[1] I ask everyone to submit
patches and pull requests for wireless-next by Monday September 9th.
That way we have enough time to prepare for the last wireless-next pull
request for v6.12.

Kalle

[1] https://lore.kernel.org/all/20240820113034.73448a88@kernel.org/

