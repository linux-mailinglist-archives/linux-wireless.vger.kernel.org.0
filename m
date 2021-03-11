Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CC6337FFB
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Mar 2021 23:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhCKWA6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Mar 2021 17:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhCKWAv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Mar 2021 17:00:51 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696F2C061574
        for <linux-wireless@vger.kernel.org>; Thu, 11 Mar 2021 14:00:51 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id lr10-20020a17090b4b8ab02900dd61b95c5eso7497931pjb.4
        for <linux-wireless@vger.kernel.org>; Thu, 11 Mar 2021 14:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=/M9hd3Fd6M5jt8WTcf4h3sjl7uFoFUyY13LocA6J0fI=;
        b=YSbX3qLvvcHh4IB1LKbzWxBcneUhEg65wJR8r/PS5ODM8/1/NkA62E6vNMJ07ks/Yo
         Ky90G6JJgIFt6tFycAKPEqqronUAZ/by3JFU0mxOhNaGy/u6zaIg7EQyzfH5rTOJtJBy
         5uhtOVtherAf/NVnaAKHJwlC7LxfC/A670eTSqSCJbDpn/R6AePDm2LM1uKXJMTl5fRG
         YQ0vliSOGIjKHn+8Kx8ZRrKR7MAvTkviEW2lzWAt+cGd/DEoGDKYmf+VDkNL/YzDay8p
         SD+SWhdErLGwkikjDFuyqZU3NMCoeKl2ytIFpu0XrKPYU+8t5jQDWUPhqL38+y4JrFcv
         aWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=/M9hd3Fd6M5jt8WTcf4h3sjl7uFoFUyY13LocA6J0fI=;
        b=nTMmFH9JIXgZXZpUiTa5f11uwx50hk9KbB1HXZIetSy+rXyKMErW1IgxAhvyfRW3ni
         9+UTuvDjXwzBpR37HNz20V5U2V+05tMM44stt4LcyIGf5DahFMJGXENMGg0RLbfadU4J
         J8hZ69U3QYAPgjAwsnG1BcZvdEYy4ylmhCjAOJGEZB3lt/QaRqjhzyBdfyoqpT9HId80
         nIBY63GWiWjC2iBAz48C+yF6eQCzLDUDoiCIKO5pWLb1f5DaZaEXWNoyBOdv87SbbOsZ
         K6/EkC5EUvdfOKDgsIWwjHfmvejuSyAYjTt1Ok6uxWHI1EAqw6yIDBacavtS8nClQXaB
         uNIw==
X-Gm-Message-State: AOAM531Arp6WENkTaFDcpmO1qMwPsyFj0+QVrNrGj0RBd7RPu9c9adH2
        r/kSae6o8Hwq6iqxNmi1U9vCiKyEP4w=
X-Google-Smtp-Source: ABdhPJxddylrncUKc0VAM4ZxnbrbyMDy5LwTwknGX9rrWmxnbcTTEIc+LJhmlwYrqF1QGpHXMLEzig==
X-Received: by 2002:a17:90a:c004:: with SMTP id p4mr10802172pjt.202.1615500050700;
        Thu, 11 Mar 2021 14:00:50 -0800 (PST)
Received: from jprestwo-xps ([50.39.173.103])
        by smtp.gmail.com with ESMTPSA id o20sm3116684pfu.154.2021.03.11.14.00.49
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 14:00:50 -0800 (PST)
Message-ID: <76d03f421dd7db33755675e424541a64aac95310.camel@gmail.com>
Subject: brcmfmac: Getting IEs from CMD_ROAM
From:   James Prestwood <prestwoj@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Thu, 11 Mar 2021 14:00:49 -0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Adding FW roaming support to IWD has led me down this rabbit hole with
CMD_ROAM, and I am attempting to understand how wpa_supplicant handles
this. The brcmfmac card I am using sends a CMD_ROAM event which
contains some response IEs but no RSN element (nor any scan information
like frequency, rssi, etc, thats another topic). This prevents the
supplicant from being able to complete the 4-way handshake.

Now, I have a dirty hack to re-use the previous BSS's RSN element which
*works* but this will break e.g. roaming between WPA1 <-> WPA2, plus
802.11 requires that the authenticator IE is verified during the 4-way, 
which cant reliably happen if we just use an arbitrary RSN element from
another BSS.

Is this a known issue? I'm trying to read the code in wpa_supplicant
and its making my head spin. It does attempt to parse the RSN element
from CMD_ROAM, but I expect that fails since its not included. If it
doesn't get it from CMD_ROAM where does it get it from? Or does it
spoof it like I am?

Thanks,
James

