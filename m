Return-Path: <linux-wireless+bounces-32577-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHm/EFsjqmkPMAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32577-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 01:44:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7950219EA7
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 01:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B08E3007661
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 00:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71A12E11C7;
	Fri,  6 Mar 2026 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgKM4Ee1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530E72E7162
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 00:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772757840; cv=none; b=MqNfCzgwdBdN6KblTMEf8QXAzRAs1/Zp4WrqwRMafFRYHVinqu4T351ALTwkfPgbhfXFVBBbmrYJ4iGs8sTtXEoJzv4TVg/en4tvfrl5fb/DV7YYohwQJ3pH/icyi2oiYVNa/n9h1Z7ZklyFgVaz2Pl4lp1XqEf/t8YDUJS3gOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772757840; c=relaxed/simple;
	bh=SlxNkWeYG2jC8F4dtE1l8oVL/VcZqLqk8x6VI232W0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIMuUMAO8EHcem2EfzuRZUPJHWheVHAF0ROG7qdDFkDkmtTdBXHtYMA2lYwnMQ1u7mzfkQvowTDjVCJ+kOdMk1fzLQMvlu3zsy2pHrg2Nr45WUKsfsjj/WzP1lSdU4CXMLG8xvLy4UQS6/sBYNzcGCiVJLCygakcn+N8Nt07fHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgKM4Ee1; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-463ba60966aso3143168b6e.1
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 16:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772757838; x=1773362638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQ8acXeUu2flgK+dNZrWf/T7XYkkUKe2qrxt7AXt0W8=;
        b=TgKM4Ee1shtqjFqAYX/Tvu24mMHzHYWDHwbcUrxByCXE9jIUgDEiA3Tgo6dYq+ifCc
         WDCcVvSagAULwIIo9hsBP0NVU0erG7BKNDwtloqo9r3vL3TZ2O/9lLAqEb/y7COLWUmi
         4GBwj02/d+o9dHsssatWS2WO18AWoxkwndEN/6R8W6r7G3YY925j9OwIeP8XKTdhAV1t
         D9SXQubmL5WElie9VbBc2GGiYtUvs8EyxLyH516nIDfgb7u0CkfVeLVd+HGGlmSW3jJT
         3lA+Kwn2jp3ZATM9bKtGTX0TMSqr0QYmTJo8LXDdmeRE+g3yLYMQQMqtWW6lAxRjfe6c
         GBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772757838; x=1773362638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MQ8acXeUu2flgK+dNZrWf/T7XYkkUKe2qrxt7AXt0W8=;
        b=jFiVbGu7RsN7grye90AxuBqoryUZQotxrToj3zB0FCKr0cEOIgFMPjiwK4p0s0JavI
         7Fz4HafGyOlugJIZwXMWuVBCrF/AQTxCWasF57sZuinq0WELMeQjt5p5wOBgSYjz4ag+
         aIduxlVbGwAEMqmXtw3zgfOfr8plbGHkBkETUXZ2WqO29JojWYX5BD8l7u3wwxSea7aX
         +WS2bbCdb2z6Yd2wtUpFSqsbYI54MrO8hT7HnH342p9Q+C+Vi22pgRjkeoSXsP1bndsC
         dG1O4myeZE0Gl+RW2xMKnmK0o0DO6tpfWSfR/qLIJLtETlWtEuVaNIms5uypoz3oW185
         qffg==
X-Gm-Message-State: AOJu0YxOJ4iwadJQSvRBgDrKbHW/6oZ18wOhSfstv/OBzt2yAbg0SrAs
	gZ8WIy6WJKv16J9UhFgMVDIae/ANWEXMV+Gh4UUMcsYtwSSvTLJlqGsVxloQ7lW+72Q=
X-Gm-Gg: ATEYQzwEi1M2ix7F83S3K9jgCVDBC02kmLseY+CCn/1yGRthqSeCs7dKhmUEpuyi5p9
	kXhQ+IEd7DSDD/btNL4ITrxz5kFebjW2olsrvo5kz7OYF3vKHsW/HbnRUc4BdjL55HLHkU84UGv
	JH2T6CJZJxoifkjz5rbFtmoRlWsrjVd+S/6KhyxSM/IRExAndD8Z23XfDoPBQlstQWYJdRbeSOU
	BIgUvGa6fdg+3kI8zIWFSex+AeOYcB7wDuNhHNJRfSsDLZspQweLsumOcSoj0KCzIdWhWXfBe3+
	4pMS0vUWUBGU+7usFKrXFMjwZ7t+Qx9sZ+gM++bJ030DqiXe1jpqVBnm+UBh7+/rn++gHZNOwid
	HRarPJL10wMGytMlSjpMH3OF7vRER8jumq+zJiNz6KoIbIZO+13BexIj8Klmlkq+CCRSmPwF0Bi
	HP+iZ58OC1rybtzWU2QfBg8fK3ZtjuR62i+gNkObwXIM5XRhH3L0bkd7fQMAWvmyRNKwnLHbGP8
	3t4SmlUGoWLgvdaKvzHpsfIaOpPdCuPaGQq7aoL6Q==
X-Received: by 2002:a05:6808:1a1b:b0:45f:1387:973b with SMTP id 5614622812f47-466dca7e5aamr210025b6e.6.1772757838015;
        Thu, 05 Mar 2026 16:43:58 -0800 (PST)
Received: from framework.misc.iastate.edu ([2610:130:110:25d:2aa4:4aff:fed7:9b19])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1c82sm69335fac.5.2026.03.05.16.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:43:57 -0800 (PST)
From: Kerigan Creighton <kerigancreighton@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: loic.poulain@oss.qualcomm.com,
	wcn36xx@lists.infradead.org,
	andersson@kernel.org,
	mathieu.poirier@linaro.org,
	linux-remoteproc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kerigan Creighton <kerigancreighton@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v3 2/3] remoteproc: qcom_wcnss_iris: Add support for WCN3610
Date: Thu,  5 Mar 2026 18:43:43 -0600
Message-ID: <20260306004344.10968-3-kerigancreighton@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306004344.10968-1-kerigancreighton@gmail.com>
References: <20260306004344.10968-1-kerigancreighton@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C7950219EA7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,lists.infradead.org,kernel.org,linaro.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-32577-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerigancreighton@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Action: no action

WCN3610 has the same regulator requirements as
WCN3620, so in qcom_wcnss_iris, we can use wcn3620_data.

A separate compatible is needed for WCN3610 because the
wcn36xx driver uses it for chip-specific configuration.
Specifically, it sets BTC (Bluetooth Coexistence) CFGs,
disables ENABLE_DYNAMIC_RA_START_RATE, and disables
STA_POWERSAVE for this specific chip for stable
functionality.

Signed-off-by: Kerigan Creighton <kerigancreighton@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
 - Move remoteproc compatible string addition to the middle of
   the patch set.
 - Add Reviewed-by Dmitry (thanks!)

Changes in v3:
 - Describe why we need a new compatible in the remoteproc
   patch [Krzysztof].
---
 drivers/remoteproc/qcom_wcnss_iris.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/qcom_wcnss_iris.c b/drivers/remoteproc/qcom_wcnss_iris.c
index 2b89b4db6c..e58b59355f 100644
--- a/drivers/remoteproc/qcom_wcnss_iris.c
+++ b/drivers/remoteproc/qcom_wcnss_iris.c
@@ -95,6 +95,7 @@ void qcom_iris_disable(struct qcom_iris *iris)
 }
 
 static const struct of_device_id iris_of_match[] = {
+	{ .compatible = "qcom,wcn3610", .data = &wcn3620_data },
 	{ .compatible = "qcom,wcn3620", .data = &wcn3620_data },
 	{ .compatible = "qcom,wcn3660", .data = &wcn3660_data },
 	{ .compatible = "qcom,wcn3660b", .data = &wcn3680_data },
-- 
2.53.0


