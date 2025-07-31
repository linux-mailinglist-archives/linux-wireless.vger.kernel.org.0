Return-Path: <linux-wireless+bounces-26065-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35527B173FE
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 17:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6496E58642D
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 15:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F90DBE6C;
	Thu, 31 Jul 2025 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0UCWK7r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9187482
	for <linux-wireless@vger.kernel.org>; Thu, 31 Jul 2025 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753976051; cv=none; b=UC6u1U2+owETzP3jB63t+YNOaYrwkuRdCLAVsczI5cYft3ZSkQu2vRRD2srcL8mYdg0u3252ge3nI+Vu06Fc1GcJZIoR29piv0J60k7I6pi3Gv0sKQf+87NLysIljYrGMOM+B8g9Kc3NFJXuFQ8a9iHeUI3m0gHtgnMsHjJktHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753976051; c=relaxed/simple;
	bh=/DbdOR03CG+fHJqy+ql3n316LM1XPqyNW+BPxIMwfGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDEeK9zto8Rr6JJVrixEMNKfBe7jB/kcGImMonYXtK+zRsJCsBv6rIOs4wm3mGMxmEB7qaZ82O/oHMkMXNZMBJh7ehu9G4DanjjRV7f4Gn7slhDU70/7Lz9H9aXRyWtxD3gh3k0vk3mGrUggiQe8vQ9chyh3SLs33OBiJBXqw24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d0UCWK7r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753976048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/DbdOR03CG+fHJqy+ql3n316LM1XPqyNW+BPxIMwfGU=;
	b=d0UCWK7r6KNgOi6EnTphk3im+SkCFdzxMCfH9LF8Bv2SHaC9//JY3JgdBVdL9U8OXNBEfy
	doJkFxhAyi66tJ+5HFg3YjYa3GObkEYPg6AZlS/4cOWYGCtKGaAIjmO2l64QyR+yMUGhZ3
	YV8ue0f/A/s6D0wIsu+OvPMb1VyZFnI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-2I0UBwalO5WwzxV_2sW5vA-1; Thu,
 31 Jul 2025 11:34:02 -0400
X-MC-Unique: 2I0UBwalO5WwzxV_2sW5vA-1
X-Mimecast-MFC-AGG-ID: 2I0UBwalO5WwzxV_2sW5vA_1753976041
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FAB019560AA;
	Thu, 31 Jul 2025 15:34:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.118])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 78B1618003FC;
	Thu, 31 Jul 2025 15:33:55 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: lorenzo@kernel.org
Cc: angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	matthias.bgg@gmail.com,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	shayne.chen@mediatek.com,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: Re: [PATCH mt76 1/2] wifi: mt76: mt7996: Set def_wcid pointer in mt7996_mac_sta_init_link()
Date: Thu, 31 Jul 2025 17:33:50 +0200
Message-ID: <20250731153350.379834-1-jtornosm@redhat.com>
In-Reply-To: <20250731-mt7996-mlo-devel-v1-1-7ff4094285d0@kernel.org>
References: <20250731-mt7996-mlo-devel-v1-1-7ff4094285d0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Tested-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>


