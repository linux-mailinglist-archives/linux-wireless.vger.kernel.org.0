Return-Path: <linux-wireless+bounces-36109-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EddFguK/WnWfgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36109-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 09:00:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D12DF4F2B40
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 09:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CA2B3034AB7
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2026 06:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212873502A9;
	Fri,  8 May 2026 06:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQDoXFJt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8608E35AC1E
	for <linux-wireless@vger.kernel.org>; Fri,  8 May 2026 06:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223553; cv=none; b=WpzW5hlSaW2ROls7gx5LSZR5XmSnupvZO9nDSUHiL4Mz9BPw5Wh6KIYUMgu0SD1uGs0ardQuQOjkIRZN7MBPpcDrt0gGh7B7zXt1oPCUOpgGCBRFTPY0xF8b0gbsEUQsrv21A94jBkRVevpG/VZg/+vd0Eijo98rjWon7Z5TmEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223553; c=relaxed/simple;
	bh=zJ3Rgqy/OY55KE7/hjKXeVg0Qb9DTMFvoIw7T7QmRfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSX9PA9atJStjhyWClOC4h6w15PwmPr5YjiiPAhq6wPddmMXtJtOw7k+8GHzAU0ZzxCNmfgd7T2GjsCnuGWBXDQd440UWkui/8YtMVNPYbCWRnYXICrQ5VFveH346xgpDtwYYm7N5LhpJe4tleqNKQ60l4htNlJl6CyumwgzDQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQDoXFJt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ba856db1c0so11681535ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 23:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778223549; x=1778828349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJ3Rgqy/OY55KE7/hjKXeVg0Qb9DTMFvoIw7T7QmRfw=;
        b=dQDoXFJti0H2Y8pYI/mLCsRtMnxCTjA4iX6FVcIKRmbA8lEeZyqk+4LPm4j6AkFXnk
         T+s/X7qEwFw7mWLdILHzIztMvMO1VlpO/nXUwx0AvLZlLDALscZ9yt44yUTT+bCPZpWI
         YIcoQhndcNsFXoFgPs4gQXqYXivBasMip06W00WMEG7pLcJaSjh3JccHEzAs5ZIrjRXZ
         Cqyqt/BwBdZe7qovE206AlXFpHAokRmLlq2cC5j0H/2mI4t6aAUnvaIeKBycJkdcpU3u
         +Uh+tDaxiZgydiH8BwvFV92V9tUjwGaT8PPiK74VV4nh0ntm7jTwGR/heLiYAuBy0tcH
         Q5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778223549; x=1778828349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zJ3Rgqy/OY55KE7/hjKXeVg0Qb9DTMFvoIw7T7QmRfw=;
        b=DDUXcT9YnNFQBxw9sJZl8qsMFvI5Myl0GQl4Zg4xOVVx+2co49JDEp4v62TqLUjn5K
         kqQ07tyjovWDZL4EX5lmmR0nsy9opNRN5LA6B7wxX5UenNciVbhvAxj2o3RKdof8KCwg
         bgv9HGyFtqAGqonEMCD5Qc/iJs/7QWrTgUHxUg2zCUU53iJqmysqHyxq+rV/FyZgY4QN
         Z3THEcbKMdEnusXfcXIOMNi1+KjRD0U3XePP9kpdHcsR0I4YIUG/U3cTxjA3g+2YpnAc
         OeGkFe5rL7cOJ7p8jOB9FSTG0jiD5U54YSEGkui01R1glWosa3fGYbr0Cs+q5EWQZxwb
         KqTA==
X-Forwarded-Encrypted: i=1; AFNElJ+gB/uJouGsjKj29l+Ogjh26axhJN1c7hxI/CvJCC6UppnsNJ1/5hZW3gin347Jjgyh1Fz0Fgi6szXjN+e0mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7TKEktktmb80+x7IjyJfMV28DYkNpG6jvR+tQ+fvKFbEwXq/K
	7Mbna03MC/hCtOj/tydrNbVtazHE1SiE75PkMSs22+RqnjkioO+95fmN
X-Gm-Gg: Acq92OEH6TSPC15EXojsZM6FG0V5DlO/Z3XJg+zvX0Cij8eJ8hOw+nZemKv/LJgTbP7
	RohqbEa5vRSg8FY9SQjO4Ac7MgaETi1Q84CA6hZ+W69cXf50m+CK/Mm5DdJVzNr4w2QFYlwc36g
	XrXoBHtkqUFfPrVPTUkgi7TT6CbNnSMtd6EHRqRGVlQbd9mvmWcYt03NMncjgQTKRRdF6UsEaor
	6Ayk2idMPx9qP9uQanVDU+oTx8icPOUfsh0B0BPQcbM+U2Eprv0v0gRLMiQaJj19E/Cmew9KwCF
	Y9lK3vb69apjWMdqUQNVxmXQYrvfH3gD2MZFl+6ZCdEbNAidKSkpdach3j97I9Nt+1CrkrE2yZl
	27UcF8FtJDVvOyta9Xjt9Jj/XXXYJ9WcZdvJg8ySZbbw68ZaybExwNjyhkRJLrEkE2FMR9FaPFO
	ebzN2KkGPcOXMI24d++zyezbsVBsAzE3teZHelhkszS2M/x2/HC0cW
X-Received: by 2002:a17:903:151:b0:2b4:5cea:f61c with SMTP id d9443c01a7336-2ba78b48767mr80839585ad.4.1778223549526;
        Thu, 07 May 2026 23:59:09 -0700 (PDT)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2baf1e36596sm10188935ad.48.2026.05.07.23.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:59:09 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: lucid_duck@justthetip.ca
Cc: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Subject: RE: [PATCH 1/1] wifi: rtw89: usb: Support switching to USB 3 mode
Date: Fri,  8 May 2026 14:59:04 +0800
Message-ID: <20260508065904.1925-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508054421.128938-2-lucid_duck@justthetip.ca>
References: <20260508054421.128938-2-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D12DF4F2B40
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36109-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,realtek.com,gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[zenmchen@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

I don't remember Bitterblue allows you to upstream his work.

