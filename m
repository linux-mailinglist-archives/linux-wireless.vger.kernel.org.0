Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597F96F1A0D
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 15:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346173AbjD1N4P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 09:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjD1N4O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 09:56:14 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E01A171E
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 06:56:14 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f19b9d5358so76895585e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 06:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682690172; x=1685282172;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lN6ZH6CIrNE0KT/OlcPAHKY4iybPDBrxjoMtRJOd8aA=;
        b=qBWVLAmUcc9MtObvn/Do+I6SJZEFBwNY95NjNlwbxxroVPupqJ7NFM5ZoAL7PHOHpI
         6Khezn1peuKFD45XW9oYFLABXMhXbdQ08Gqd12aByOSSlMX3/eZHBS4iQB84ssWLgccL
         x5nWE6hln2pLx6OFpNtIUu7My5Qp/eSjbl0MZEId1SxSghzGyZy6T0r4oiDZNeriQu/M
         L2JN1DBVTdTsy5k6uJAXrjYNFCNsIjvnDeLqVRB1NbSSmO6P+/6sxiLf2Vqn3s+FvHmy
         3THBKl/AiCmz1tlh+YAc8PnyNEBPpLqqNXafwUg3BkdTlwPUQrs9HeFIWsIwr1aseOsW
         FenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682690172; x=1685282172;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lN6ZH6CIrNE0KT/OlcPAHKY4iybPDBrxjoMtRJOd8aA=;
        b=foW71Xufs+lmAJDD31zxgaQxaTQR+Pptc4ghp5NjCI3gx7uDv6IDH0vFeztoH9/JSM
         oiNz0sgBfrC2EaOSTaJ7XKCF+h95sVmd2AiqJLpKS8r8Wwr+x1TCTYlZrolw4Fasgpha
         grqUFIin7T++oWx5pvqXKHc3HFH7tAsvSsQtV51aJKOkzL9nK6XcwWPTJmSuJmEt/AKn
         zuUYH/mXfRrK6kNwATC+FvEdBsQHtbnlhzc2r/pssxquipKiwhlaF9rz/Zu/yPrkrW0e
         P0F78BFQ/hSMt7+Sfpot5J9VNugBM0vgCN/851uEkNjudbrjPLbzsZsPStLr3t2anJts
         A7BQ==
X-Gm-Message-State: AC+VfDytccNHtiBWtZj2R7Bo6owIb4dYGC5hK0OVsKbGrm3jDHVEn8lC
        /vjeotWbmfQl/ZXeLtGu9CFHO4rq2woKM3VgzsnkRnrHJDo=
X-Google-Smtp-Source: ACHHUZ54LtRtYYF0r3gbczenbxKnBqoKoGswsCoIplEcoTorJe8pFPFTVx9JXDe2mLHwd3TnMX/TsvnfR8mZhB+ako0=
X-Received: by 2002:a1c:6a05:0:b0:3f1:95af:172c with SMTP id
 f5-20020a1c6a05000000b003f195af172cmr3851405wmc.41.1682690172417; Fri, 28 Apr
 2023 06:56:12 -0700 (PDT)
MIME-Version: 1.0
From:   Gabriel Tisan <gabriel.tisan@gmail.com>
Date:   Fri, 28 Apr 2023 15:56:01 +0200
Message-ID: <CAD9ZU8BcYM_zZqFzTBFDQOoF0Jd3vNj4OWODOy+UZbWXCUwA7A@mail.gmail.com>
Subject: rtw88: 8822cu (LM842) --> LOWER_UP link messages
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi !

I use a LM842 wifi stick on a Linux kernel 5.15 with last patches for
rtw88 from linux-next applied.
Firmware version is 9.9.15

When I connect LM842 as a station to an AP, after the link is up first
time, it comes from time to time more LOWER_UP message.
The stick is plugged and the connection to AP is still valid.

# ip -oneline -family inet monitor link

5: wlan0: <BROADCAST,MULTICAST> mtu 1500 qdisc noqueue state DOWN
group default \    link/ether 34:c9:f0:99:b6:a1 brd ff:ff:ff:ff:ff:ff

5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue
state DOWN group default \    link/ether 34:c9:f0:99:b6:a1 brd
ff:ff:ff:ff:ff:ff

5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue
state DOWN group default \    link/ether 34:c9:f0:99:b6:a1 brd
ff:ff:ff:ff:ff:ff

5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP> \    link/ether

5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
noqueue state DORMANT group default \    link/ether 34:c9:f0:99:b6:a1
brd ff:ff:ff:ff:ff:ff

5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether

5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether

5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether

5: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
state UP group default \    link/ether 34:c9:f0:99:b6:a1 brd
ff:ff:ff:ff:ff:ff



5: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether

5: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether

5: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether

5: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether

5: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether

5: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether





Any idea what I can do ?

Did someone also reproduce that problem ?



Regards,

Gabriel
