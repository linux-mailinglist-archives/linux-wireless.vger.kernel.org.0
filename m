Return-Path: <linux-wireless+bounces-14138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47019A1BD1
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 09:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66322284BAA
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 07:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C4F18784A;
	Thu, 17 Oct 2024 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRR7yUhK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC081CBE9E
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729150772; cv=none; b=qOla76XUbz/1TTtSBXXb6ypdjl05HKpx9cJEzIZuyRKm0hoFNfLrthjOxVH7JCa8kuKxYv5paQPXb2lKp3X8flncZMqXqFSm9JZ3yxJLonIkOKpzBLwJxn71t7Zj7TQc2wdB7KECLTTTpBGvgWASMfeVpiVZnmD5/wM24vMyA4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729150772; c=relaxed/simple;
	bh=m4eEYHr5HZdR14z2m0HhKfVxLLSkjgYI0qJOJpkvDww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uc/xFnl9ghHQmvN5zhpEer2ihG3dlp3I8k+M78Q6Sig6xSznqUy/XXU/Wue0p8UQl2jHfa9LjchPtpeQXN4+hqbDbopb1scCHzGOLYwDpLE65RXXtFDj3OjeKRxaHzVncQa5HLsVjqb8VnrHY+UttaTA7wj68vzv7vYMnQKpI1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SRR7yUhK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729150770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4eEYHr5HZdR14z2m0HhKfVxLLSkjgYI0qJOJpkvDww=;
	b=SRR7yUhKxlaNfa03by5qBnaPkiogNCxPp5SZWz5QqFQ8FjRGA83s1FFNxQ9YB3jrSnyaua
	YlHLWNssS9L3Gc01g+5o+55phdk/38Qz8KFjh0rT11lKRewZOa/WiNVCYDGnPZbz+TEQeI
	/zfyyGHux/bGTx7jVp6u4rg6cOqnijw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-hZvoJQuhPv-T_dST5p10zA-1; Thu,
 17 Oct 2024 03:39:26 -0400
X-MC-Unique: hZvoJQuhPv-T_dST5p10zA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7AD7919560AB;
	Thu, 17 Oct 2024 07:39:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.60.16.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 461B8300018D;
	Thu, 17 Oct 2024 07:39:21 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: quic_jjohnson@quicinc.com
Cc: ath12k@lists.infradead.org,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] wifi: ath12k: fix crash when unbinding
Date: Thu, 17 Oct 2024 09:39:17 +0200
Message-ID: <20241017073920.176412-1-jtornosm@redhat.com>
In-Reply-To: <7edcf090-ac17-45de-a81e-33a1bb520126@quicinc.com>
References: <7edcf090-ac17-45de-a81e-33a1bb520126@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello Jeff,

> FYI I didn't comment on this previously but
> <https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages>
> has some guidance on trimming backtraces in commit messages.
Ok, I will trim the backtrace in a next version of the patch.
And I will fix the typos too.

> I still don't understand why this check is necessary.
>
> Why isn't just adding the "dp->tx_ring[i].tx_status = NULL" inside the loop
> sufficient?
>
> You previously wrote the "warning comes from free_large_kmalloc". Is that
> warning due to a NULL pointer, or due to a double free?
>
> I don't see how it could be from a NULL pointer since in kfree() the 1st thing
> it does is trace the entry, but then the 2nd thing it does is return "if
> (unlikely(ZERO_OR_NULL_PTR(object)))"
>
> So I'm suspecting a double free, and setting dp->tx_ring[i].tx_status = NULL
> should fix that issue.
Sorry, I didn't understand you at the beginning and I thought that you were
referring to the complete fix (including setting to NULL). You are right, it
is a double free and the test is not necessary, just set to NULL after
freeing.

Thanks

Best regards
José Ignacio


