Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E258276BA2D
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 19:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjHARBO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 13:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbjHARBN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 13:01:13 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F03D268C
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 10:01:11 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a426e70575so3503762b6e.0
        for <linux-wireless@vger.kernel.org>; Tue, 01 Aug 2023 10:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690909270; x=1691514070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fGImeCu371NZRVmhsoIhyHtxIghtAXz4GYkB18szDwk=;
        b=QvGu7XgmZ3KKHBcs7g5gLs3hc87SCh+HV0G5G4wkUOaTXurSD0z7cTNcF0xgcXxzhK
         VN4RcfIXntFubxOBOjMzAl3qIAmpMjehbQdq7MxlsDzS+7XShvZ+f6hHrnJqP5JQutwK
         yk+2PmriLju1TAYCVfSxGrWhtJfj6Qq7lBUCA3cGFNeTcakHpqujqQH7SfvINSPCD+wu
         nY0QpK6JkjzSg+GwQsj1pb70z0JH3LjGGv2DP9CZRREc/W3oMETRsamsPeo6xIuxFxjH
         29STwD0AcILU+QcElrdjwTqBDHw3szV/9KTds/yJxZf5xHunHbOYN2WVAmsg3YgBTMx6
         jlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690909270; x=1691514070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGImeCu371NZRVmhsoIhyHtxIghtAXz4GYkB18szDwk=;
        b=aVHY+4tdZwXfCq6XOsjdcPNuyE1g0bQS1Mv9qj9V+/wsTi24Cu/5wfx9IZi16jv2fP
         f8DDiC9vvmbzf7Xs7hw2RJIh9BcKK9hA3pPuI3LTta7hziN4B8WoEDxWOzu3DAIBaGfZ
         a1OjydFjKN0RoW9TDXUxiBidsMp/+va8XBA7/oNBx45X4OdwX1NL/NbFkuFo6CtS7GeQ
         1jY8jDaARjPGCkOMM67oFjkSR9qUAIG1V9Q+6+ZYRjo6CxD+LOPveg1TOHJ7OlVXId1K
         LyMtzdL4sbGqkwPA7bKvxj+DWU+kwW7FfSiYIPubnxDJUSrPhC3fag3bS82bi7I1ZaZW
         mhoA==
X-Gm-Message-State: ABy/qLbAmb7TDyaZ2mqlWoHlAbd4TQqUJG82e+Hc39DKT4x8UKO7+3K7
        W0eUUyjJAbcwA1q+fWBOtCs=
X-Google-Smtp-Source: APBJJlG7+Ekf7vbpyOpwn11e+pCv7i6y3updUNwYaQgYeEGFw34g9CZ0p4Sj1sPbfome61TgWlS6fg==
X-Received: by 2002:a05:6808:190d:b0:3a3:ebc3:d582 with SMTP id bf13-20020a056808190d00b003a3ebc3d582mr15624599oib.18.1690909270374;
        Tue, 01 Aug 2023 10:01:10 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id bd16-20020a056808221000b003a1f444307esm5302506oib.58.2023.08.01.10.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:01:09 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 0/2] Change MAINTAINERS for rtl8180 and rtl8187
Date:   Tue,  1 Aug 2023 12:00:50 -0500
Message-ID: <20230801170052.6432-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The MAINTAINERS entry for rtl8180 and rtw8187 are out of date.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry Finger (2):
  MAINTAINERS: Update entry for rtl8187
  MAINTAINERS: Update tree entry for rtl8180

 MAINTAINERS | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.41.0

