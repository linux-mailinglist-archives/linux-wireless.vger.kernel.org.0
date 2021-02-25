Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5AC324A3D
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Feb 2021 06:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbhBYFmj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Feb 2021 00:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbhBYFmg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Feb 2021 00:42:36 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C2FC061574
        for <linux-wireless@vger.kernel.org>; Wed, 24 Feb 2021 21:41:56 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id j24so2888075pfi.2
        for <linux-wireless@vger.kernel.org>; Wed, 24 Feb 2021 21:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:references:from:subject:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vqYLS49mdUrLll/QWQNMToJj2OIq/glDt9d+PAr/ovk=;
        b=iDIahor/Xq+fZ3sy7bWJ8gr89P986vgB0VQgm+ql7YNRRcVrLXo3cymqimXKvzNKSa
         4U+As28EqIg8ua5BINn+C3uMxsfexsbPyC1/qg8s4X5Dv4T5mZJAi9pTEX9bwfVpcdNl
         cwKNKSdT1SoY0mwHg+5Yp48rE9kUD/GOkGNJVAwgxSIfHYoO8rYm977+AsMjRMq31Wsz
         4F+Q5dPMJXfVQxUZp1cIvLHtCn1NCccWd5axCtmuZ4B1voP19k6R38CuWad8XimURwlR
         1zaJb2GnK48Mmz1xqNrPo+AU8oTdP2awXNktgtFzP5eFp0fVngQP/5FrjnY5yJY0r484
         nhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:references:from:subject:message-id
         :date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vqYLS49mdUrLll/QWQNMToJj2OIq/glDt9d+PAr/ovk=;
        b=DmSZmKeyV6uhxK5CaMpcdIn4A4XMEKWAu72hs1zCVjyWj/epGha0rD6XGTVlZXbl1k
         XqDrllmSnYGy9Pjf4VzU5M7SkEPi9E7KeKRURsPSRBqK7D/r8khpYxiwnIScoq0y+BPd
         GvW+0KnhlNFiN7qmlaHuLujg9PqMym/+2JBbV6iiUQCv0edlNMu1jl0EZeloaAwGZBNM
         NogDdnH0aK4IDjUtQ4ewMWsZup9yuVnJTMMRzorZugJYR7oRYRps1kakOqHK49iQ0bB3
         IntGvrTLBPfQ32AE3IYFtpASnVvqwS7bPvJsT0K34zZZP9mic34WQzANr7esbm3NXw+F
         AltQ==
X-Gm-Message-State: AOAM531h+lMPc01x2g++LwSpRD9KUuvx08uF8ZTjn4lFKFsx/uiYzsQP
        HR6mqokz+iNqadVddBVPGcfDIc4Cts8u7g==
X-Google-Smtp-Source: ABdhPJz3qsTNDmS42dMVno/vPjM6J6xHLZ4ziABIzp5Rn4xpl3oNAxTGeOxABO80cA1nptRsOXV93w==
X-Received: by 2002:a63:cf15:: with SMTP id j21mr1534497pgg.160.1614231715877;
        Wed, 24 Feb 2021 21:41:55 -0800 (PST)
Received: from [192.168.43.197] ([113.210.106.7])
        by smtp.gmail.com with ESMTPSA id f13sm4401094pgu.36.2021.02.24.21.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 21:41:55 -0800 (PST)
Sender: Robbi Nespu Mohd <robbi.nespu@gmail.com>
To:     antoniotrabalza@gmail.com, linux-wireless@vger.kernel.org
References: <loom.20130617T165559-455@post.gmane.org>
From:   Robbi Nespu <robbinespu@gmail.com>
Subject: Re: Missing firmware iwlwifi-2030-5.ucode
Message-ID: <cee8c91c-50fa-7f35-9aed-fb374ce6a558@gmail.com>
Date:   Thu, 25 Feb 2021 13:41:52 +0800
MIME-Version: 1.0
In-Reply-To: <loom.20130617T165559-455@post.gmane.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

You are right Antonio, saw your 2013 email[1] which is the same 
frustration happen to me (in year 2021) to hunt firmware not in the 
firmware repository.. Ugh why some released driver needed a firmware 
version that could never be obtained anywhere...

[1] 
https://lore.kernel.org/linux-wireless/loom.20130617T165559-455@post.gmane.org/
-- 
Email : Robbi Nespu <robbinespu AT SPAMFREE gmail DOT com>
PGP fingerprint : D311 B5FF EEE6 0BE8 9C91 FA9E 0C81 FA30 3B3A 80BA
PGP key : https://keybase.io/robbinespu/pgp_keys.asc
