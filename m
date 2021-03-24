Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1B73483BA
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Mar 2021 22:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbhCXVbJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Mar 2021 17:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbhCXVah (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Mar 2021 17:30:37 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE13C06174A
        for <linux-wireless@vger.kernel.org>; Wed, 24 Mar 2021 14:30:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y5so18454126pfn.1
        for <linux-wireless@vger.kernel.org>; Wed, 24 Mar 2021 14:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=qGZ9BjKIPXO3JUI7Rb+CvH6678rBOV3pKINqW0jJ6WM=;
        b=g42IyqvH5gmCaP24YWrVokmZAGGaUwfMOysif8FRLt7JEUWv74lFG6gPhI+rPXVc1L
         7/fyIAwyoW/retuTC7qE8XRyTMkWmfnOWADyH2EkLZnTSo1k0j1MPdAozPzEEOPFmDVk
         TaLhEz1/RgBR9xQTvXRkGZLTJ7uKb1d966VCkrPe3dKyyqDp/452tbTcUSj0uGclaBoW
         erS/Osu05/LCl4eLHf7UV4hzAjDkI7CGG8cqfx+eY0tB1MBOSw30BBW3oQ72A2oGsfB4
         iqg90x1QOiwHQH4EJT8k46wOIkJf/m6RHvr3knIAnkSeXF/NKeSR/kw7LEX31snGLWnE
         kAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=qGZ9BjKIPXO3JUI7Rb+CvH6678rBOV3pKINqW0jJ6WM=;
        b=r/1v91EidrxjzGHqGOOgJOrBNW+k8mjXUrFbB8jVwMLNSybC5Q7QPD8U/rUkpWoHzo
         e8bPKJZdxGDTT1lKo2XMX1jMsSNdNxNUoiQo0rFZgCPNl0ttpriKKJ7+6gO2gPfIllDt
         i0+1RucCHzUzLUHtw19Vza4kpnxl8D3pCY07r+Ys4LRd8LZnjbCD8YVjFHV0BncnQp85
         IRai4//Dj8nEaMuDSYFyELVmCR9IJoSTk4Nu01+oB922IQm0qDEJO9KsN+rfQQ2gZ7vh
         oVJx4pxrKP3YARx+UwUBGeAJRrm9sLN48obDzqoZKqJo8+uVTQk4zdZ084zdkAyw655A
         O9Pw==
X-Gm-Message-State: AOAM531qiIO79B2zPUiwOzjG5OLcql8KXvW8FOPyhbSDHcy78Gk0ENuU
        ntNJ0RTgtNAhb4Lxn+pcLcFKucP0sCQ=
X-Google-Smtp-Source: ABdhPJzOwCufC4NtAF3vzng13rj+uaNdrBzqs/9GNv8p68H8HTATyXGkaPPSclBwqk6FGtFt/kmXqA==
X-Received: by 2002:a63:d242:: with SMTP id t2mr4582390pgi.431.1616621436234;
        Wed, 24 Mar 2021 14:30:36 -0700 (PDT)
Received: from jprestwo-xps ([50.39.173.103])
        by smtp.gmail.com with ESMTPSA id t1sm3631320pfc.173.2021.03.24.14.30.35
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:30:35 -0700 (PDT)
Message-ID: <e1ff2a8eef465eaa76e8d00503d04e0fdd61a878.camel@gmail.com>
Subject: BUG: brcmfmac fails to connect after offload connection
From:   James Prestwood <prestwoj@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Wed, 24 Mar 2021 14:30:35 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I discovered this bug where, after an offloaded connection (SAE/WPA3 in
my case), the kernel/driver/firmware can no longer connect via non-
offload means. This is due to the firmware no longer forwarding eapol
frames so the supplicant cannot complete the 4-way handshake. I am
testing on a Raspberry Pi 3 B+ (BCM43438). To reproduce:

1. Connect initially to a WPA3 network using SAE_OFFLOAD. This is done
with CMD_CONNECT using the SAE_PASSWORD attribute. This works as
expected.

2. Disconnect from WPA3 network

3. Connect to another network without using offload. In my case I am
connecting to a WPA2 network using CMD_CONNECT but not including
ATTR_PMK. This will rely on the supplicant doing the 4-way in
userspace.

Expected behavior: Connecting to the 2nd WPA2 network using non-offload 
should work.

Actual behavior: Connection/4-way times out due to the firmware not
forwarding any eapol frames to userspace.

The only way to 'fix' this situation is to fully reboot the device and
reload the firmware. Once the firmware is 'fresh' it can do non-offload 
connections without issues. It is only after you do a single offload
connection the firmware gets stuck in this state where it no longer
forwards eapol frames to userspace.

I asked a question some time ago about a suspicious wording in the
nl80211 docs regarding offload and that some hardware may not support
the 4-way in userspace. I'm curious if maybe offload/non-offload is not
intended to be used together. It would sure be nice to get an answer to
that question. Maybe this issue is not really a bug, but a consequence
of using non-offload/offload together? Anyways, hopefully this reaches
the right people.

Thanks,
James

