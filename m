Return-Path: <linux-wireless+bounces-32576-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMvjAVEjqmkPMAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32576-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 01:44:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC13C219E8A
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 01:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D8FA3017BD1
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 00:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC072E2DD2;
	Fri,  6 Mar 2026 00:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCIl/OnO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D5B2DF717
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772757838; cv=none; b=PmUtIk1GK82kyHLwmE/+brqMUFTH6LAXJ9EATOMinXW/ivZIVXi4wBAP5DNlS5T/kWeyTQiq2L3N4UIENMPOvIcJu1SNaG3cJJGc7SnsY0QEAklA7cXl9yr93ZDet355hDWWdAQylu6h5lBwdzqwYE46xoycfDt7gabGEIIA7r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772757838; c=relaxed/simple;
	bh=SwKQHqFPugEY5LBsRfzbny5oSAeUyqfWxPylHIWs5QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tORMFqlZdDWNx09k+OEju75UdtscDspO1GyukmlglqtgmwsfhXHQ/H5+qwwyofi2WQr8cBO1NHv3vjMw6/9/ne4JaS3uAklox3GCcvZ1v5On8TT8iRycpHhISTEfR6o5EUBMxQkA9xFp5TLCOvXVZ+74RLe3ouVwY4ot2kxHhvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCIl/OnO; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-45f10d7eb81so3363670b6e.3
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 16:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772757835; x=1773362635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5AiypmAgBLdMR9CuIx3DJ9/2CMWwdsmjB28iBee1fMM=;
        b=LCIl/OnOy9RfQ10XhstZa5HsHrYgab5cv0xfEj/fDZeK3CUE48bZCzHkBtYXcQqZCb
         IJwtYhijdoqpLeVEjuMyQGziuR/C9jLrxYHBWfRSR/AFX1a0OLBG72rfMBS6SHE0ubEG
         12PqrIdDBBe1z7CPa9as4c/5BuctiMaWbFGFvRRxdqFc+BAA+bDAvw8FdGJCs2ZNGio4
         B+QGzpyGw9oJOvVGT0M/Tir4fpPlJPxVO1DNJUArw71Lm/bOhIIXFOFqKIwL/yXHBY0d
         d8qebC5glmdhtf93nvj02Fc/hD+BCgbZIjPhx+QQdKqhU9l4cvpt7s3VJAcsotcflZUG
         5/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772757835; x=1773362635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AiypmAgBLdMR9CuIx3DJ9/2CMWwdsmjB28iBee1fMM=;
        b=HUt5ULfRkX6Kh4x3VZ7MflCP3vQ0JV7/WIxVA7pe/ODt0odvmoVqkuPNLNj+2N1Pva
         zoSGAQPVK/tAjVwa4PegBtGGEW8uxfunYIfJxvpEM1x+Awzpo7NxkEkOnQ/lfEg8iorA
         lLuzD4Z097IiG9stMYrJYetXFYBWFjf4MYZK3N8YW+3bad/yLoexD69CFc44z+ZoNNIu
         sngqTkdCws0a1lcD9WG1aOOiwobyK1Ubjk/sZ+pTZp33CMiOU9MII7x0brz14DGsjjle
         G+k5pQKubwKdbQRP+mGdD4wfy0o+l8OSIYtHIMOOPtWJuEvsdUgB991z5rLF44pzML6X
         aYTw==
X-Gm-Message-State: AOJu0YxHT6WnCo+2f4UFzS4ZeXErJWDZXtUqz8lYaqQP0xzGgGGpNtEK
	6PlWC1HBoQEXeQSjvOhG4rpLXnIpUkZbq406qn4MS8jn/MX63y9n3nEGR/pfbi/co1o=
X-Gm-Gg: ATEYQzx2OMj+oB3jEr2WX7qELh9uE2fLbtSI5IPtR5R6g7FSilWrRncvYThErZZTCIg
	oRnF8kyyLt+KCnpUIdMv3cHbTCQgnojVZZvUr5uX8QlogA0KDJ4RfAAj/B58VMOS94oAmOvywV4
	E1fLibqyn7jqz3bvRvE08HgGPE/DjEOsTgZZgckE9+vVkrno4WFkrw6B+x05H2Zw8athv+RWIHV
	u5Rz3qfbulZw2T9A9KtZS5JtbioNj35BvUhEGio5F9H+DBebjcg6bTD8ZZTcS1FxslLFliiAO3v
	HifuFTNlG0wmN27WNBOevcI8zqNiTOTYC+oEpAFDV3oMlMmNcToh5GsHTxNLBDz3B8jJTqwe2ES
	65x1Gl2okwPWnT8DNydWElXvZzZaUsChI8HeUeIqNywAF235qUr6Weimtup7cAL8t7aMkdKBKID
	xviIjE1EiajGMJKXU0BgaC6vHbE74lICFXmbJQa8nqlY38EJbPOCk4qoRqcaWA7+VrG8kXI880K
	Z2RJayNgwzFbnrPhml8MitlquAUF6SaJcMYSag74A==
X-Received: by 2002:a05:6808:c3d5:b0:45f:13fe:4a2d with SMTP id 5614622812f47-466dc9f4738mr204774b6e.4.1772757835483;
        Thu, 05 Mar 2026 16:43:55 -0800 (PST)
Received: from framework.misc.iastate.edu ([2610:130:110:25d:2aa4:4aff:fed7:9b19])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1c82sm69335fac.5.2026.03.05.16.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:43:55 -0800 (PST)
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
	Kerigan Creighton <kerigancreighton@gmail.com>
Subject: [PATCH v3 0/3] Add support for Qualcomm WCN3610
Date: Thu,  5 Mar 2026 18:43:41 -0600
Message-ID: <20260306004344.10968-1-kerigancreighton@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AC13C219E8A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,lists.infradead.org,kernel.org,linaro.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-32576-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerigancreighton@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

The WCN3610 is a 2.4GHz-only WLAN/BT combo chip used in some 
cheaper Android and Windows phones such as the Lumia 550, and 
IoT devices like the Anki Vector robot. It shares a lot in 
common with the WCN3620.

This series adds support for the WCN3610 across the necessary 
subsystems:

   * Document the new compatible string (patch 1).
   * Add compatible string in qcom_wcnss_iris (patch 2).
   * Add rf_id and CFGs for the WCN3610 in wcn36xx, disable
     powersave for this specific chip, ensure it is 2.4GHz-only
     (patch 3).

Tested on an Anki Vector 1.0 and 2.0 robot. Support for other 
WCN36xx chips has not been affected.

Changes in v2:
 - Move the Documentation patch to the beginning of the patch set.
 - Move remoteproc compatible string addition to the middle of 
   the patch set.
 - Add Reviewed-by Dmitry (thanks!) to remoteproc compatible patch.
 - Move wcn36xx driver changes to the end of the patch set.

Changes in v3:
 - Describe the hardware rather than the driver in the 
   dt-bindings patch [Krzysztof].
 - Describe why we need a new compatible in the remoteproc 
   patch [Krzysztof].
 - Describe where the CFG values came from in the wcn36xx 
   driver patch [Konrad].

Kerigan Creighton (3):
  dt-bindings: remoteproc: qcom,wcnss-pil: Add wcn3610 compatible
  remoteproc: qcom_wcnss_iris: Add support for WCN3610
  wifi: wcn36xx: Add support for WCN3610

 .../bindings/remoteproc/qcom,wcnss-pil.yaml   |  1 +
 drivers/net/wireless/ath/wcn36xx/main.c       |  4 +-
 drivers/net/wireless/ath/wcn36xx/smd.c        | 61 ++++++++++++++++++-
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h    |  1 +
 drivers/remoteproc/qcom_wcnss_iris.c          |  1 +
 5 files changed, 66 insertions(+), 2 deletions(-)

-- 
2.53.0


