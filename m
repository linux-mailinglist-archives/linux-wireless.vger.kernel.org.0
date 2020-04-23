Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDCC1B66F3
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 00:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgDWWmu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 18:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDWWmu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 18:42:50 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBF7C09B042
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 15:42:50 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x23so6113742lfq.1
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 15:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=QQh5TbUcEFHlBHWtlsoUJ1QMZN/5m/ZGAHT1sQWwKdU=;
        b=AbIsqKK/xhFtEJvZrsz+RPdNZdrTz7nGLElqxgB0Y1hXfQ5TXH03y7CxzWQVpMYSZc
         Y5i48hfjyET9ONQNgcFMzPC5T5m4ffE8uNRwLWLJgz+Mlu8i8kzZkvIP9nv61mEiLUt9
         GWgdzJ6dGvS6iQ52dReQtCzBWqoi24OqMJiuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QQh5TbUcEFHlBHWtlsoUJ1QMZN/5m/ZGAHT1sQWwKdU=;
        b=s75CZRTwMQIgFKHHgjONwwGRLGHmhmQlxLVMSn4p5fTaWnSHzL9GHctg280MWRZw2G
         mil9RVuribAmziNNC1OOHj+bmcbJdSY5h3RAK4AjFAM+Fb9m/60r/3zAnB+0G7iNXq8s
         LPGAweaME6FpaYLer6jIQ4/cHkTmEOft6LLMexluG3wSCaoyrgPK2gl7ZyPT7vXmSF+1
         W6MCneLuTxJekf7s3gD8hq9Vhqln3t/yS9vXxBnz+FEhQCPYUIudtcMjFbT3RBlvbTEv
         3dGDrIW8VHiuj/9b2Sq7+S2EoEQAIJSiivh8joCRSg1kzdmF9zqWJf4vrGTxHsPjDbXD
         eDhw==
X-Gm-Message-State: AGi0PuZt1BfKgSiplhmoau5rG2+oxqq5SRYNv+uHz9d+aeuizhIaPCuO
        +YqmKne4kOwC6h5c40ZJvqJCQuu7giU=
X-Google-Smtp-Source: APiQypKJkSDAjl2MgXU87ZHbwpdYcij6xS6c6uBDRUG/e5Laprrv4j+KkvXfz9JSMxz5rR5sHQ2bHw==
X-Received: by 2002:a19:9109:: with SMTP id t9mr4002408lfd.10.1587681768436;
        Thu, 23 Apr 2020 15:42:48 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id b28sm2992941lfo.46.2020.04.23.15.42.46
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 15:42:47 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id f18so7926209lja.13
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 15:42:46 -0700 (PDT)
X-Received: by 2002:a2e:90c9:: with SMTP id o9mr2682136ljg.187.1587681766433;
 Thu, 23 Apr 2020 15:42:46 -0700 (PDT)
MIME-Version: 1.0
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 23 Apr 2020 15:42:34 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMghcm-g8uWr2rJOmAOkYocWGCvXKtqs171TQ52DZXmPw@mail.gmail.com>
Message-ID: <CA+ASDXMghcm-g8uWr2rJOmAOkYocWGCvXKtqs171TQ52DZXmPw@mail.gmail.com>
Subject: bugzilla.kernel.org / networking_wireless@kernel-bugs.osdl.org
To:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Does anybody actually triage/manage the Wireless component on
bugzilla.kernel.org?
https://bugzilla.kernel.org/describecomponents.cgi?product=Networking

It's ostensibly managed by networking_wireless@kernel-bugs.osdl.org,
but I get the impression that list (and really, the entire domain...)
has been dead for a long time.

Related: does anybody care to fix that up? I've found a few useful bug
reports there recently, and it would be nice if the community could
proactively handle those, instead of leaving it there as the
equivalent of /dev/null.

If no one else volunteers, I'd probably at least try to stick my email
in there somewhere [1], so I can manage state (e.g., close issues that
are already fixed).

Brian

[1] I guess I'd have to ask kernel.org admins?
