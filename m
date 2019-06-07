Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3216D38E04
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 16:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfFGOud (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 10:50:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37865 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbfFGOud (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 10:50:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14so2462460wrr.4
        for <linux-wireless@vger.kernel.org>; Fri, 07 Jun 2019 07:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SyIPK0uGfVvmF4vYYnPSL82M9o5wEbDTCrjl6r/aHXI=;
        b=yR0habUDsptvaNtxi8t7Zb+xCxIU3fB55eZXPPy/tPwfoLPuXh14x02PlI/YMjVm/f
         Yn8pI2IAfCnWCJRaA9QZajb9cDny131ZDPqebR3CPLTvDFx7+MzJfCGQXnAGqcqQQHt+
         hhBp2mM7KC/fnOzsUvAGiVrjbPgdFfHIzVr71mtRH6ozzZ41klqN798QPbdNsHr0qBcR
         gtaeZixmzDPAOLfFqJ2ck/v7nc952YY4Qj6TCpHmH+updMSr1mSq1P8oCARmh1/QMEtJ
         vipItAXhpO+CRBzZryrIBb1AL16VqEfAc6Qy/+XZbmWtW/i6kbxSVhOzKBzOhsZZXqWV
         pRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SyIPK0uGfVvmF4vYYnPSL82M9o5wEbDTCrjl6r/aHXI=;
        b=QsFf9Ez824F8UdM8BJ+4TLADpngXdkjDYSyKpay2UklRTmWAyfk06Xq5WJy0Z6Dgel
         1qr964Zso3hwR2zVr8bNrloBLktKekrHIvXpudVzCsTZQuua6xpncY5D0h7k0AsuQ+vw
         mCgSMXiORQR8rM0wX9Rf/hvlrye0HSPVcMyYpZL/hC4jzDO80iyuuHr34PWlTUs0tYkb
         2W1n2oLqvVjVOQk6BlkezZ2OydVNsJuR/Ur8nwcu65lFVxwA+n4fQCKDg1+ZyQayqks4
         qvbeWVEIncIJQnj2MiTztbExy9xbMBgSebrVLPz18QIHmJ7igFpq6Lm0UDamY3+VJ1L1
         m6Sw==
X-Gm-Message-State: APjAAAWEejTC5mTFeiJTXTNIbvXn/UxpYJEI/S4k5QtKGy4QSypht915
        xMUJcUXMpPXmtTE9XSyIUEjgWA==
X-Google-Smtp-Source: APXvYqxUBW3msIX4EhYmbwjgUhDr4jBHmDzriq7zWS+2FwJB4snr/s+c6QALwCt62jyT0Pj9Wuh28w==
X-Received: by 2002:adf:b689:: with SMTP id j9mr12793509wre.76.1559919031531;
        Fri, 07 Jun 2019 07:50:31 -0700 (PDT)
Received: from localhost.localdomain (aaubervilliers-681-1-126-188.w90-88.abo.wanadoo.fr. [90.88.7.188])
        by smtp.gmail.com with ESMTPSA id t13sm4129354wra.81.2019.06.07.07.50.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 07:50:30 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org,
        johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        davem@davemloft.net, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [RFC PATCH 0/3] move WEP implementation to skcipher interface
Date:   Fri,  7 Jun 2019 16:49:41 +0200
Message-Id: <20190607144944.13485-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

One of the issues that I would like to see addressed in the crypto API
is they way the cipher abstraction is used. In general, a cipher should
never be used directly, and so it would be much better to clean up the
existing uses of ciphers outside of the crypto subsystem itself, so that
we can make the cipher abstraction part of the internal API, only to
be used by templates or crypto drivers that require them as a callback.

As a first step, this series moves all users of the 'arc4' cipher to
the ecb(arc4) skcipher, which happens to be implemented by the same
driver, and is already a stream cipher, given that ARC4_BLOCK_SIZE
actually evaluates to 1.

Next step would be to switch the users of the 'des' and 'aes' ciphers
to other interfaces that are more appropriate, either ecb(...) or a
library interface, which may be more appropriate in some cases. In any
case, the end result should be that ciphers are no longer used outside
of crypto/ and drivers/crypto/

This series is presented as an RFC, since I am mostly interested in
discussing the above, but I prefer to do so in the context of actual
patches rather than an abstract discussion.

Ard Biesheuvel (3):
  net/mac80211: switch to skcipher interface for arc4
  lib80211/tkip: switch to skcipher interface for arc4
  lib80211/wep: switch to skcipher interface for arc4

 net/mac80211/ieee80211_i.h         |  6 +-
 net/mac80211/key.h                 |  1 +
 net/mac80211/tkip.c                |  8 +-
 net/mac80211/tkip.h                |  4 +-
 net/mac80211/wep.c                 | 81 +++++++++++++++-----
 net/mac80211/wep.h                 |  4 +-
 net/mac80211/wpa.c                 |  4 +-
 net/wireless/lib80211_crypt_tkip.c | 61 ++++++++++-----
 net/wireless/lib80211_crypt_wep.c  | 52 +++++++++----
 9 files changed, 153 insertions(+), 68 deletions(-)

-- 
2.20.1

