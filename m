Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D303E408DEB
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 15:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240742AbhIMNah (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 09:30:37 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:57990
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241239AbhIMNXk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 09:23:40 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2283E40259
        for <linux-wireless@vger.kernel.org>; Mon, 13 Sep 2021 13:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631539249;
        bh=hZ5N4zB6ne7AqKTWsazgl2eww5+7SrfSBiF0jiwRIRU=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=YVPjkpxazpwtlErABeAyFzKOrvyoRQPu8vkoaZD3jaK228LtlT1jkpUs8zmtEpGM4
         19eLOISGw60zBhZH4W/1ckAC5sWOSXfwQrq7vfq9JLFl6OmsUqs+nGwH7IhR4H5Ifa
         hpGA8L79QoTP1/tZ7cXVPXnl9bO+n3/DuLQybit0HcLfKg5HH+GQ1Z4RYByMCBVOfF
         Jvs2VEGjQ1hmbp0+wolSiSSOMy07KsRF2oD6zkXqIpwO16TF3MVzBb6HbTph/iJrC5
         jXVTB0eOBe2HTC9Z8T24up1d42EyeT0uYrLgnROxQ7sAF/RaWGIHENexD5VNfR7xV1
         meDlXx8hUB/mQ==
Received: by mail-wm1-f71.google.com with SMTP id z26-20020a1c4c1a000000b00300ec9d8d77so1451624wmf.5
        for <linux-wireless@vger.kernel.org>; Mon, 13 Sep 2021 06:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZ5N4zB6ne7AqKTWsazgl2eww5+7SrfSBiF0jiwRIRU=;
        b=ObhOrz6bnPO2e83rLxTuJcNkdP4BVh4AK/ttCmi4R6eD+HrmDYFCvvlz83E57RJMuh
         g3C8CP+CuWkRtdoYPrk2Mntffc6FzqiOf1oNxHxujJ3rAVnbSU0o3HmYTs63VGcxTCch
         QHiL9IAcRPQHjDKeomiEHy5dEIJ9JB6bsw6hC/DGiSCVNLuWAWUhCxG24FAzuKBA+Gz1
         nuW3OroY54UOERkPLjuRoPgZK0MK1foaiwa+As+j/7wXkUlieYGaiJQch860tk2NofTD
         Wt/o594mSDL9jGcJsVNH3as+B4/pkt5ylE6SJK0gMjOdJCy4Z1vqRoTiUB7hT5xLKaSR
         +xXQ==
X-Gm-Message-State: AOAM533L9tKy+h2yq1qwdJSTtpSrQ5SpLTW02ZBB+6NlVYLAVVC+ETD6
        9FnQ3cc5K+MIG3c9vM5zHH8VKEexYFi2z+OqTqRR0K3xa3nWy2Gr6DVLeE4wnC0H5GUmcWe+f26
        XG87croowEQ5V0h4ngXgiFCW8EaExfzFZEPYBt0EUspSQ
X-Received: by 2002:a7b:cbd4:: with SMTP id n20mr11406242wmi.136.1631539248171;
        Mon, 13 Sep 2021 06:20:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGW1ojaPyD1M/BS656w+4FJLzZXRQcOiJW5oHFj8BydpZT1RYPdlEY9jeHIFid1HBy2UQTIw==
X-Received: by 2002:a7b:cbd4:: with SMTP id n20mr11406199wmi.136.1631539247756;
        Mon, 13 Sep 2021 06:20:47 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n3sm7195888wmi.0.2021.09.13.06.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 06:20:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH v2 04/15] nfc: fdp: drop unneeded debug prints
Date:   Mon, 13 Sep 2021 15:20:24 +0200
Message-Id: <20210913132035.242870-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
References: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ftrace is a preferred and standard way to debug entering and exiting
functions so drop useless debug prints.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/fdp/i2c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
index 051c43a2a52f..f78670bf41e0 100644
--- a/drivers/nfc/fdp/i2c.c
+++ b/drivers/nfc/fdp/i2c.c
@@ -335,7 +335,6 @@ static int fdp_nci_i2c_probe(struct i2c_client *client)
 		return r;
 	}
 
-	dev_dbg(dev, "I2C driver loaded\n");
 	return 0;
 }
 
-- 
2.30.2

