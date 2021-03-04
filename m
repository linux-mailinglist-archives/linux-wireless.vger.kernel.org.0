Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAA032C8ED
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 02:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbhCDA6g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Mar 2021 19:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388623AbhCDAMN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Mar 2021 19:12:13 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9210CC061763
        for <linux-wireless@vger.kernel.org>; Wed,  3 Mar 2021 16:06:30 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k66so7887455wmf.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Mar 2021 16:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Dw8xFgrZVztIlPSuTy10oAfdTu62xOSo1BQjghZZXo8=;
        b=Cld5GzQlscnuJ4EmVzW8EFD/IWW4j+t6apQ87rw4rSpHip0miKspaqhC5lH3UHXsPK
         zcRgqG1DuzC3oSDDTzcIRuMxuOcEmXp7y1bKIPN3veJsljeeymg1GVUU+uZvGIGBJ5RW
         BDe0329dBpnTi4moeiRkdHtloP1lzxZMLF8MmcNmNiYv3ZT4sA8J+6RWPE8lUZb/wl7R
         CD2uL3IrjlocBsn1FGvKfH9mWq0AlHkSwkPFB4PkVaeEt7rk/eAMjbAjcx6Qn9SYlF6X
         QB2fQnHNQPJCsMJh/JnrpunsfiOUJf9tAt52neMAqxEVRpoIL0iFrTz9y2UoPv5DS5r4
         0t1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Dw8xFgrZVztIlPSuTy10oAfdTu62xOSo1BQjghZZXo8=;
        b=ikb4o1QdYtUVLZW+jIhK85kWuwejLs5SlTj7X37AGGUK3ccuf2Ir0W1OW0N9o9eIxB
         TYs8IHpG+oMCCxt27LH9e97BRiwsZa8NMlcsjYIPk4TH+D1VhugNjKIO/OZwOmz6zb75
         UH/qEOljODwQYwo3tIAj8rbIT/ZqhiK5xa9pSHW5IqcyAg+QYAxnfpnUxIYOOrcPmrPV
         yiIc/6ypJySAhCP9EhlQESdP7UHSRv7wW4kzTgwaHupL1+WfQItGt6nUMq/IHwfW8jaI
         YkrSEWlOeVvnZLozdx3nPGTYapGZ9/4VuT9BkaBneTgwBOQnqs5o6i5f43P/UBSh0MpZ
         4E7A==
X-Gm-Message-State: AOAM532MAG/z6tlktm9MKu87Ino4fTEBH+necbA0t2KWXA9d0qC0IuAD
        rupM/pLxOsq7oZpBnD9ZgVL2WMDpOGVKlScyAEBMP8mIUNs=
X-Google-Smtp-Source: ABdhPJxwvxkSuioJ6cVc090AvFJzuCWSo4fDesiQKoRU2tb4ibvA0hQhkYzN6tdA5yNZkua/xgTdc0CTeqtLV98Ltgk=
X-Received: by 2002:a05:600c:2947:: with SMTP id n7mr1180349wmd.61.1614816389028;
 Wed, 03 Mar 2021 16:06:29 -0800 (PST)
MIME-Version: 1.0
From:   Joshua Zhao <swzhao@gmail.com>
Date:   Wed, 3 Mar 2021 16:06:18 -0800
Message-ID: <CAKmTU=qZUm5T=nOMT-4cpJekKevLETwxY07CDe00iwLxkMpJGQ@mail.gmail.com>
Subject: bridge mac80211_hwsim AP to internet?
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,
I'm using mac80211_hwsim to simulate a virtual STA and a virtual AP.
How can I bridge the virtual AP to a backhaul link on my PC (e.g. a
physical ethernet link) for real internet connection? i.e. so that my
virtual STA can access the internet.  The AP could be configured in
NAT mode or layer-2 bridge mode. Is it possible/supported?

Many thanks!
Joshua
