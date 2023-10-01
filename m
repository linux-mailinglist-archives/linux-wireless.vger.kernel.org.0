Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705AD7B46C7
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Oct 2023 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbjJAK2Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Oct 2023 06:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbjJAK2Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Oct 2023 06:28:24 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C7EBD
        for <linux-wireless@vger.kernel.org>; Sun,  1 Oct 2023 03:28:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99357737980so2132592366b.2
        for <linux-wireless@vger.kernel.org>; Sun, 01 Oct 2023 03:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696156100; x=1696760900; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hQu7UTTMEhpbsLfWcYaug4VHPEY1RKA+rGnJ7mjF9Yc=;
        b=MhyQlKFBa/z/rSSjCDWFwYbeKR3RGilrBIQe1ghQgj42fJK2eB11NDdsLCq4G5N8YA
         R2txhbcW7uE/FRciPLH8huVghsx2MdcXJR+GBQy7wPmFVV19k9oVtmjYHA8M1wmhqVS2
         8ayWFmnKhsdP+LYChaJmupGnHrxYf9BUbnWga0FVtLTjuBoGrYIDLatB2NpyNtCLea+b
         G7h9s2XrXVbXyN7FomlkW0i8ktrAqEGIokWDaBJLlfof+FPN7eYSLoYME5DVHw1bnfx0
         cmr9hMSj7OBw6JkZm8UPuS1BFtQvQwgPDET/UeHC44cG25ZEMJBfwcXAIuUaMfmmayMI
         VLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696156100; x=1696760900;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hQu7UTTMEhpbsLfWcYaug4VHPEY1RKA+rGnJ7mjF9Yc=;
        b=sO53rd4zeSvtKxNr0EFa6/Co4VKaxuR9guRIcOTbwl3rQvDfaazmUgPV03+F5Eswmv
         Sne+J52BxYsR9UsQ8+89dRhF/LMri6/96tHFkMHYq11/BKTFDreTe0rHfKcJS721uaSv
         tYM4xtgNVv2YfEtWjQOIMig3zvFqC2RAV2VN0O8CLlvaztRrN98TD3eZj8yZ+aer1lyW
         9tf0TpGU1MNgYv0Z8GyDcE65H7++cM7eOzEwnvZa5MbRO1PqwsVgKPwVEBmq2D5kVQwG
         uru7Y4bXbeWxGfrslhkepg/dbLHnoESFTLE0+mVdS1w1JcMK9ccM19E/Fn7dSq8grv3Y
         54xQ==
X-Gm-Message-State: AOJu0Yz8qWSkvXhZnd4LQHH5PUADDr2foFDnyDAZdYbK0OnBJ7SGpZVF
        I4Qio/XgdBpZ+jbxDZtd882zlZVnHW6H3gxDZ7YSUIg6TKlQzg==
X-Google-Smtp-Source: AGHT+IEcVsrN7VOdHxB6xLw3xA7Pwlbna64QBAzV/g7nleQBXY2dlcNP7ZrDT0oneM0rOtrtlq4NjuT59SbKlpNWVkA=
X-Received: by 2002:a17:906:3150:b0:9b2:babd:cd44 with SMTP id
 e16-20020a170906315000b009b2babdcd44mr7992150eje.44.1696156100010; Sun, 01
 Oct 2023 03:28:20 -0700 (PDT)
MIME-Version: 1.0
From:   James Dutton <james.dutton@gmail.com>
Date:   Sun, 1 Oct 2023 11:27:44 +0100
Message-ID: <CAAMvbhGsA4A9qHrYdXcNXLzv7a7xZZq98f90Q-Btb-9vs9ayCw@mail.gmail.com>
Subject: mac80211 bugs
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I recently saw a report of a kernel bug that was caused by a null
pointer reference in:
mac80211.c: sta_set_sinfo()

Now, looking at the kernel source code, I can see sta_set_sinfo()
dereferencing pointers.
The function is a void function, so there is no defensive programming
going on in the wifi drivers here.
It would seem sensible to try to log a message and return an -EINVAL,
rather than crashing/halting the entire kernel, but a void function
cannot return anything.

Why is there no defensive/security-by-design programming in the Linux
wifi drivers?

Kind Regards

James

P.S. The stack trace is here:
https://github.com/openwrt/openwrt/issues/13198
