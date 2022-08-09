Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9839358E12F
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Aug 2022 22:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiHIUfY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Aug 2022 16:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbiHIUfV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Aug 2022 16:35:21 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5030362E1
        for <linux-wireless@vger.kernel.org>; Tue,  9 Aug 2022 13:35:20 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id n185so6837337wmn.4
        for <linux-wireless@vger.kernel.org>; Tue, 09 Aug 2022 13:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=oNWNozI9iBrClNUUX2Vj6i1hza4qDVwm9A1CS6S2BfA=;
        b=Fg2YLIpJM+TiQq2eL7VKibVR0wOGvhO8Te+nlVNuupYGeeP7JIr//HWupUp7CRqq5n
         JF/Qhif8QwkMzJjWVZaJY8QTcu/zFz0VhvpCMRY1UYlul/A3sZFJ9N+YKzsc0YeCUHlF
         tk5ky3+HpyBPs4u6AKObXnE5D7XGUJaM7EEIc4v9fiOAGmGKBl2pl5xdyEDW2OXBOspu
         ASPLlLCEYUbfHFhE5HEyJPjUaiwjyxo6aSewVzvvklCosJfpOH0SBQUd9UotrWlG5/Fr
         sC5AHz0sKrrKKetwj2H4kD8HKQysi3uOWOT28MXHXoaAyjTaW2XYrLeh7PRUeGWtCNWC
         n5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=oNWNozI9iBrClNUUX2Vj6i1hza4qDVwm9A1CS6S2BfA=;
        b=hC/U+bCIjVma3bpfRKNMt/yZfAD9Fsu4XyeD5toiLopu8WmkSdEK9AZN/j6HZL4Kr3
         ExHcL5e9NTZYp06G3KOianUJGULUWv/oDctp00U4ucfFn+MSrcUx56FZixeroMZesw3S
         ecYDJsf2vp5kCb7lRkkFoS/BQJ6Qb8oFle4OVITVhYqeZkR1TH8lT+bx7BVx7jpWw+zv
         LRfyJbHMa+cPanVuH9wt4VqprSw3pRzZG20K8G1ZMx7f/YEgegqhLibE4d89K7Vw7xHF
         hdj/4PT4AM042Ya5JUVaB5O0mRSVStIR3rAtC5FBwoivipxFDSdLJ6c/ODMjenY82fMu
         BI7Q==
X-Gm-Message-State: ACgBeo1ZTP+WZRy4bY3cWu4wqZ67ojxxNy5fksM2qE/sUxJ3jBcI7N1N
        3njWiiJVCKBn0/bg8HCyvnlo0rub8XRZzjMHtgA=
X-Google-Smtp-Source: AA6agR5TTxBjwyfYf7+FbbGyU25wcLsxo5kb+b38CfXhkx5fJvx7gxwhfmpgdP/OzvXwoxZv+O4F9L9nLC3V+a3WJG4=
X-Received: by 2002:a05:600c:19cc:b0:3a3:3cfe:d548 with SMTP id
 u12-20020a05600c19cc00b003a33cfed548mr152239wmq.6.1660077318794; Tue, 09 Aug
 2022 13:35:18 -0700 (PDT)
MIME-Version: 1.0
From:   Jill McDonald <jilllmcdonaldd@gmail.com>
Date:   Tue, 9 Aug 2022 15:35:07 -0500
Message-ID: <CADb3WDmzwv5Zp9oHEAyEb=a2G7HYt=vF_LATUK3CFFQJBxay=Q@mail.gmail.com>
Subject: RE: Money20/20 Attendees Email List- 2022
To:     Jill McDonald <jilllmcdonaldd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_FROM,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I hope you're doing great and staying healthy!

Would you be interested in acquiring Money20/20 Attendees Data List 2022?

List contain: Company Name, Contact Name, First Name, Middle Name,
Last Name, Title, Address, Street, City, Zip code, State, Country,
Telephone, Email address and more,

No of Contacts:- 12,969
Cost: $ 1,598

Looking forward for your response,

Kind Regards,
Jill McDonald
Marketing Coordinator
