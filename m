Return-Path: <linux-wireless+bounces-34841-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA56IFUR4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34841-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:29:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC28408A55
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D304A30DBCD0
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7855539448D;
	Wed, 15 Apr 2026 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmwKb4cn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D808396B84
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291843; cv=none; b=rQH1z+iVenjC4dXEiZ9Kk4I2F3vbcqDXd2VDI/iKE0FGYQIEj+jQNgJP50qsQZTidrNvGOFDQSNZRsBtT0pn3QgdSzKg3IY7/BoHSyDRwSdBXCXMl9dd0VmbVyDg8oB1xJz8QEAc8fILinBG07u1NldzcZw3HNqYEJmNktoVMgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291843; c=relaxed/simple;
	bh=FWZh+bpoeNl243+DGXsMV0oOeY5uxeAu3hfQ6f7yr+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lYebVq+47iqziKobOZon5N8vHw9121RK1QPPIKZ0fawnEvfhA9nkB2NIrP0eGDT9PlVsBcd+AIe0DUNr6TPaNxowBkuEsAjOkzKYi2wC0UtfoBv0k/CLRuj4dgKhM8hC2MzlN4IDBRPJa8p+rJnq98tNMbRReQuXcwcX82HzF30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmwKb4cn; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cfce3a195so4523246f8f.2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291840; x=1776896640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FWZh+bpoeNl243+DGXsMV0oOeY5uxeAu3hfQ6f7yr+o=;
        b=jmwKb4cn+6KZ/2HyNWE1An4deXQFRuRIMUpQ5iHfB0LHugXxv5CVOcK/ljgsGcaUzX
         GdT36+RMCO+WY1K2D+tn3uCcaUaYS4u02WuFcDtRbGr2YnA71H33ZO1GhBnH6Cc0e9+e
         H8JlL/7rwnuVPdL9sFpOKvWbyn8/lmLq24AgIbYbGWi//JLg42hifoYLzz9cPwWUcGne
         ToLn0rUyulWQjApWcezLgeXsRor1PX8nPD2tvNXzHUJ0jFJut8GcH17PRHXcPwOV5r0w
         cfN0dNYCjxLrXYRzKLrRiJP7YHjNYw2o56kOeq+EsrzSDt7m16wbAqkiwlD24Dc0hbM8
         baqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291840; x=1776896640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWZh+bpoeNl243+DGXsMV0oOeY5uxeAu3hfQ6f7yr+o=;
        b=PIjtIy4I6VXomBxm1g6DLtOaahCGj9MTVsQvuD0jo28f4lSIoMN70VXbd64tKDvyNl
         qHcHVXZp4u9Gl0RiyZ3MOY3jrYjgLqeksq+zglyNO+t38QbCUkREnH5u54+3kYkHeMxk
         vm7ME6jwjFujvmDretHtWReRtcfitlQ7QjAro/epGdbk8SiQS0W6QlQes1Ib0B0h/gnk
         je4aMqWfq+v8h7fqRi8RX17+9OKbhUhiV5LUYSGzRRQJW+//8pnuRbFyXPgRqOIiZP4A
         rp10l5Z2e63EFHhqBx72cAVI02dlAuCRLZ/FOMgsE/tV53ssWQUCUo1fyjTfMhh/7PNR
         BpkA==
X-Forwarded-Encrypted: i=1; AFNElJ/PZmS+5RtR47BCH4ziNr2NQ47/k8pf0UQZrU5OkM/aGUkiNBEaP6ZkTt5CzS2YkpPc6Cs0dglcsR+WPT7eWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YymKpSCx+OtQ1txHJRgdJGiD4VE938C4NshHqcRsyRssGFCVqNZ
	EzFdUaDPy7iTe7ytozOqnOnFb+BA6YTKV1GvIjcyiLPeSY6ZfH2s9is=
X-Gm-Gg: AeBDiet+vI8/RMNh4Pl+simWQdSEv/AZ9YHnUS5AQUXViwv+iGodfsdZcLR0KD3rwgD
	ocwKD87uT4j+XmpcBse5wXruhUKtORZRHdgsZ3Zhe5SctpTNOfe/gWYXhGVqf4Zgghk8CNq3Fos
	Fz0FrBPtbFxE+JB13XBcu5JrUFydryo8kzekXrMDmym/dp7+q0vl/SKDteEtewFtUU9X00kzJwM
	6oljSi3sUjyzfMaHOZdMypS6ggqhpxoKoOpQV2QgAGfivxz1UPitENzReahe1TFiFyxz1Uqh5sH
	KjNQzNo8pqs3QuoGeqp47KWjwANn/1GWFMj417DbWxhQVWsNXe/jYkeT255TBxtI9jlNYX9oJDx
	sJH1i6jQyxFvXo11gWATXv2n0oWJQG3CC4FOcpYYoQZikn3TUPMqv25hQ5WPGxSzUa4HxXXObKf
	5JYdE=
X-Received: by 2002:a05:6000:178d:b0:43d:4a43:53db with SMTP id ffacd0b85a97d-43d642a98b4mr33564457f8f.26.1776291840421;
        Wed, 15 Apr 2026 15:24:00 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3dfff3sm7613861f8f.26.2026.04.15.15.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:23:59 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Loic Poulain <loic.poulain@linaro.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	wcn36xx@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2 0/3] wifi: wcn36xx: fix OOB reads and heap overflow from firmware responses
Date: Wed, 15 Apr 2026 22:23:55 +0000
Message-ID: <20260415222358.1541983-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34841-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ECC28408A55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

Hi Loic,

Note: this is a v2 resubmission. The original was sent via Gmail which
caused HTML rendering issues. This version uses git send-email for
proper plain-text formatting.

Three issues in wcn36xx HAL firmware response handling, including a heap
overflow in the main response dispatcher:

Proposed fixes in the following patches.

Thanks,
Tristan


