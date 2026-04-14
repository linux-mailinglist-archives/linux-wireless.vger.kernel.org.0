Return-Path: <linux-wireless+bounces-34744-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAzcBFU53mkxpgkAu9opvQ
	(envelope-from <linux-wireless+bounces-34744-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 14:55:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C51C3FA33E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 14:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A28B3034331
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 12:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90776282F3F;
	Tue, 14 Apr 2026 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=matthew.leach@collabora.com header.b="SgVTncjK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEB620DE3;
	Tue, 14 Apr 2026 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776171318; cv=pass; b=YthD9hYCs/7hjyBNlGLur3Mfsc4oBAyjac0XL7xGJeYzZJz6ndjNlpdd/Be4aUNjx7ltDGKjam9n62FaW+fW/USKpxZBbJEyrl6M/vSj9YRJaiakfRygyjVWae3qEHd8wz1SPsqPobglC9RXj3ZrDkM19FhskDorws5WHIoV0hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776171318; c=relaxed/simple;
	bh=CPqicFcytNtnzHuoW7FJrVjBpaHA25SCuocEPa2d7tU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gn2lbWck6AJh0B9AIH+21CsXdiZqilkGbW5X2NtzIsVdZYoE0GE7+Bk5hYaqxVDkcxWxrjQqNGSzYguaJjqiKeoSKtNEK/5tnE+NYaXUbdlKDZvzRgl2sedipRY24noVkKXmAuVwf7zw4KEj+XJ6/mAVXRsvQKBa6FEeS0jLVyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=matthew.leach@collabora.com header.b=SgVTncjK; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1776171298; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PcUlMX5UZ9symej9Q+NUSgMdBQRE95LhZbSCKN22rL55eKVxg9WofZ7XmkBBh8qWK2EKHFFZSJ0TN7HVg+xUzzwXQvLcVROo1WDi+bvYCnmZVYqL8D7A7pU6xn/Rlm5J3sWEPeb5wn8QeFMpTrrdA4xHSw9EzfrGzJ/mF3My2jk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776171298; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1udwrSYEoaoUgP2bIJt2dmf8dBn58zMQ1f8UWe8/+Ck=; 
	b=KNdUysAh3VeExsi8JI3xMchc4xzrtlSfYJxKZ96svR08nYjAYk3tNrUyqINq36Ea2UapxFty/uDv2e0xnm5Qv9EAkRqTg+En8Ea7oTz29D3OWInURLL2JVJ/CfL0c0WbGzRF6E3xA6KPvh4+1sQF1RwSxXJI2osXs6RCjmiOd8U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=matthew.leach@collabora.com;
	dmarc=pass header.from=<matthew.leach@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776171298;
	s=zohomail; d=collabora.com; i=matthew.leach@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=1udwrSYEoaoUgP2bIJt2dmf8dBn58zMQ1f8UWe8/+Ck=;
	b=SgVTncjKDekvDRxFkAKPpHpKFYVOeBWK3J+jvXmUULPcERNSKAw3E1J0q90N3BpA
	qjuOycWc0ih8o3vUJvYbKpCkZyrTPLr3h2vzvS9hVAyClbA/2R48I8jUrVkkZQIOI0x
	T4w5EU2sN8JOCZPtIUvu2HbNFE9zoBDzoaL6VaDo=
Received: by mx.zohomail.com with SMTPS id 1776171296260511.12827373228345;
	Tue, 14 Apr 2026 05:54:56 -0700 (PDT)
From: Matthew Leach <matthew.leach@collabora.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,  linux-wireless@vger.kernel.org,
  ath11k@lists.infradead.org,  linux-kernel@vger.kernel.org,
  kernel@collabora.com
Subject: Re: [PATCH] ath11k: workaround firmware bug where peer_id=0
In-Reply-To: <7dbc3836-c42c-4cbb-a50a-011d82a0ee81@oss.qualcomm.com> (Baochen
	Qiang's message of "Tue, 14 Apr 2026 15:06:33 +0800")
References: <20260326-ath11k-null-peerid-workaround-v1-1-0c2fd53202f8@collabora.com>
	<87h5pxlpg4.fsf@collabora.com>
	<7dbc3836-c42c-4cbb-a50a-011d82a0ee81@oss.qualcomm.com>
User-Agent: mu4e 1.14.0; emacs 30.2
Date: Tue, 14 Apr 2026 13:54:47 +0100
Message-ID: <87a4v54s88.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34744-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[matthew.leach@collabora.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:dkim,collabora.com:email,collabora.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 7C51C3FA33E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Baochen,

Baochen Qiang <baochen.qiang@oss.qualcomm.com> writes:

> On 3/30/2026 3:57 PM, Matthew Leach wrote:
>> Hello,
>> 
>> Matthew Leach <matthew.leach@collabora.com> writes:
>> 

[...]

> for chips like QCA2066 and WCN6855 etc 0 is a valid value, however
> this is not for chips like QCN9074 etc.
>
> so a possible fix would be to add hardware ops based on chips: for
> QCN9074 we keep the existing validation on 0 in the ops, while for
> QCA2066 the ops is a null func. Or even simper we can remove the
> validation for all chips.

In that case, does it make sense to remove the condition check

if (rxcb->peer_id)

in ath11k_dp_rx_h_find_peer()? It looks like this has been used as a
small optimisation, where if peer_id isn't valid it skips checking for
it in the peer hash table. However, if on newer chips peer_id=0 is
valid, we should remove this?

Regards,
-- 
Matt

