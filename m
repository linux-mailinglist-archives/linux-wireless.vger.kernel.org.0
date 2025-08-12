Return-Path: <linux-wireless+bounces-26312-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9FEB2271C
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 14:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE5F1728A0
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 12:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B81B1DC985;
	Tue, 12 Aug 2025 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVrXz/d8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E577113C3CD;
	Tue, 12 Aug 2025 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755002207; cv=none; b=JRWx4CP8KJpKXSErpNClCxfT6XmYDnQWKe5jzuDyAtjT/Kf+Yy6195p3O3b1MNpttGGl2o+2sontuth439FOxi5ctEzDuR1U84nWC6M3nT8UqmIqjhiAWyqatYaQSPFs7ZmnAhCH7JW6cvMVVCNGM91O2jlSIA64wU2rOt/2DSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755002207; c=relaxed/simple;
	bh=36qCfev6CBHhrWddvv28EObqicMIqSDDel4IWLfJoNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ipnmzk4Ur3E/Ogx52G4PFyzq9KAmcfaZP/ZFdLEnUrX5J0mqTHOITICONqWXxK1ekYZ12AwgEgXJ1MGobMEZBY/4vIchXkHvhCKtdMw1txmc9Rd91eO84kpIe9GRl6lLJmddUNCWm0lgc0khhXUwvzDAPGOvpOSYtLjx1cR5V+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVrXz/d8; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76bed310fa1so4567585b3a.2;
        Tue, 12 Aug 2025 05:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755002205; x=1755607005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KCP9QD2yVDf9WyEMP7gZz0SvVxf9faaBdK+nGQh+dYM=;
        b=JVrXz/d8g2UQGOyio01Bgq4dgmBlca9x0BDxx1Y5omYRwFCbjUwFfNt/7x+4uCXGHA
         AabBzg10f4pBlDKP5dabXXHHFeLLoILdQgpx+BFGAeauXnqGOaSfRcHTFoSo0gUqDDFU
         DjsDcx6zHxRYnfXEwi++h/5C3ZenauQwyyPV3piO5B9tDbj1eDTkMbhGBLGXnTrTxwcX
         PgFX1jMQk1ZIgWkJUpbRQl6smikZoqr2QM3G0J8pt4M9Q7IfBdozVdtGGqlaRQAyfSvg
         eXww5RJA4q77wzmcwcH1x2qVK2VbNhwD5rY9KfFazdDFYaeVnlhO2Fs+xxj7ZKF/cqvb
         OVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755002205; x=1755607005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCP9QD2yVDf9WyEMP7gZz0SvVxf9faaBdK+nGQh+dYM=;
        b=mVx57xnjp7Pyaypb3lwDLiLRkYvbFedgDTQg1zRostYicTUdC+scZQM1+6w6okvkhJ
         vhElO7xVAvmngGnBcuvZhy86nAu3kPl2pH24dnmI69MpAUwoveqbillp1bUqQ7hVqAQW
         EveNvE6h5p26Io++/CFsmg8B9ur9KJSFUytXVgVnLbe8LVJJjbEGZJ7Pu3WtAgxs9iLJ
         nsid0fJ2qEtnLkSZrWjqXhXPq4zq0wBWN9bRleCciyp+y4VOyjhWmHCHwmVfjYO6OnfX
         5mpRgaPEwYg5tL9MFZbCvfuHSnMkXzBTMVqQDXCObqui8DOHIczvteQKi1KBdPQXPFFN
         AqYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDD8Gq2EKyj/CS5DXXU6uu5JHtoFDPi+Cg11ZrjZQlh58fJiilXIPjtLK+zwjPw65IjB4W3qpFw3Ddm+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB2UdEJo39vicywoh7iZaMYbesNjSPdwmjZsB8kEHFBbMYgdBi
	+CaAEcEKa9F8mcMExTFbtxl15tNim/WLgNPo2XqdjfeXpMVyeQSET+eCHtb0sZbBWjc=
X-Gm-Gg: ASbGncsyjnU3l91Zi9/VH3N/4f/3BtCIRtNg9vr+HKgyTamVYzB2jzRn77ETIgNCj27
	060QcIodHctogQG5f1heo3DqitXBxstfgeAlh8SbnlY6xjYQco7ErwF6VrCj5MPbcgwZ8T6+nBy
	t6eyVrdg9hepl2l3a4D9sjWT0CslJSmMLdCys+5GRNep6VSqPlt3zY///mJWmYvZn6iLM2isifK
	oan0TE0OnDYkgd0+Qaf+Mrkwn4F5FdjAj1VKEV/mlB+CxOBSOKVp99BNWMiHNaeWmck5hKz8qGJ
	W5ZWvswDMiThatnwvk3D8kXEuS7GeBK0LG0AXigpFhnZtlwK1YZbPZPWE/QUZO+QPkzkMo/2+9q
	+VwlQdPSKYzKRdHfyKqyRrOfTif6V7pW1Y4Bvyyobz46rt/+1
X-Google-Smtp-Source: AGHT+IHZ/ewI4Y6s4Ti2kEtLEeMRKw80tXrowny5hfX+HTcxoMLrIZ9RNU5wYF2LB6c3wyXwKrkCxA==
X-Received: by 2002:a05:6a00:2195:b0:76b:ca98:fab4 with SMTP id d2e1a72fcca58-76c460d2e40mr21394486b3a.2.1755002204566;
        Tue, 12 Aug 2025 05:36:44 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:8898:77ef:d42e:3af1:d5eb:7170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe50c8sm29337295b3a.120.2025.08.12.05.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:36:44 -0700 (PDT)
From: darshanrathod475@gmail.com
To: arend.vanspriel@broadcom.com
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Darshan Rathod <darshanrathod475@gmail.com>
Subject: [PATCH] brcmfmac: avoid assignment in if/else-if conditions in NVRAM load path
Date: Tue, 12 Aug 2025 18:06:36 +0530
Message-Id: <20250812123636.2142292-1-darshanrathod475@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Darshan Rathod <darshanrathod475@gmail.com>

The NVRAM selection logic in brcmf_fw_request_nvram_done() used
patterns like:

    if ((data = bcm47xx_nvram_get_contents(&data_len)))
        free_bcm47xx_nvram = true;
    else if ((data = brcmf_fw_nvram_from_efi(&data_len)))
        kfree_nvram = true;

This style violates kernel coding style guidelines and triggers
checkpatch.pl errors. It also slightly reduces readability.

Refactor these cases by separating the assignment and the check,
ensuring behavior remains identical while complying with coding
standards.

Signed-off-by: Darshan Rathod <darshanrathod475@gmail.com>
---
 .../broadcom/brcm80211/brcmfmac/firmware.c         | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index 83f8ed7d00f9..ef79924fd8f4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -554,12 +554,16 @@ static int brcmf_fw_request_nvram_done(const struct firmware *fw, void *ctx)
 		data = (u8 *)fw->data;
 		data_len = fw->size;
 	} else {
-		if ((data = bcm47xx_nvram_get_contents(&data_len)))
+		data = bcm47xx_nvram_get_contents(&data_len);
+		if (data) {
 			free_bcm47xx_nvram = true;
-		else if ((data = brcmf_fw_nvram_from_efi(&data_len)))
-			kfree_nvram = true;
-		else if (!(cur->flags & BRCMF_FW_REQF_OPTIONAL))
-			goto fail;
+		} else {
+			data = brcmf_fw_nvram_from_efi(&data_len);
+			if (data)
+				kfree_nvram = true;
+			else if (!(cur->flags & BRCMF_FW_REQF_OPTIONAL))
+				goto fail;
+		}
 	}
 
 	if (data)
-- 
2.25.1


