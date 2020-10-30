Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE792A0FC8
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Oct 2020 21:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgJ3U6q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Oct 2020 16:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgJ3U6q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Oct 2020 16:58:46 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154A3C0613CF
        for <linux-wireless@vger.kernel.org>; Fri, 30 Oct 2020 13:58:46 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id o3so6198991pgr.11
        for <linux-wireless@vger.kernel.org>; Fri, 30 Oct 2020 13:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FtzmRWV4ZQZSKiqBCzb8jAVLnjSWkLkgJlWnAbiU7G4=;
        b=ctFWAmzY9pM9V3izeEQFBLP/hN9bvkE6YrEEukZfZVr/fdDY+BNDs49ukrF0meZSYf
         sO7fP3bf1NeCeRRvJLyfxY9aDJTWqzlYcTvP73ldfpzQcNdj1Okgkm0XbeXpB2LpYttB
         9LzPzIoAKKAp/Be1SteD6RR+z4LdjFWipLY70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FtzmRWV4ZQZSKiqBCzb8jAVLnjSWkLkgJlWnAbiU7G4=;
        b=CYQu/U2aicmUVIlD4N7SNEF27fznrxdljY4yUxUl8MvfA4s7xaA1Qdo2n1yJ66UTlM
         R+7d601Xm4GTtW4pQ1ML/ckOJANcsoH44cQdrtPrhTLniekOVVcg4aV5zdRhNFU4VXUi
         yp5PWRGNBJEFqiHzKKjM7vddCwiPcbxtugDhmHUuq+JqKWixpDo1WOKQb5+bg5458PBc
         0OW88Lf6wBXy0dMFYh+oedkonYwrfppgD0CWPAZyGKWZUNVFU4EAW8nTqgeliMFtV8Re
         TYPSr2Q1FMbl9SAKQYteYVIwVvUHth0D/EdvkO1nH7NofL/mduDlYgDyulpRgEanfWTu
         0WKQ==
X-Gm-Message-State: AOAM531yUDo3B2b1QkGKWr6lRvegKFpNkUxWZ7wU2pf6Ag/Np6k7b0aM
        f4+UaVZWGrzQdIXEahjUXITODQ==
X-Google-Smtp-Source: ABdhPJwSWc5Naotsu1b0Mkix08bNN//qp+bwA1P5gMbcxyWAnP/zldPfhxl/S9ZyHuXhUcA4y8B56A==
X-Received: by 2002:a62:7b47:0:b029:18a:ab71:7821 with SMTP id w68-20020a627b470000b029018aab717821mr647073pfc.3.1604091525653;
        Fri, 30 Oct 2020 13:58:45 -0700 (PDT)
Received: from kuabhs-cdev.c.googlers.com.com (56.4.82.34.bc.googleusercontent.com. [34.82.4.56])
        by smtp.gmail.com with ESMTPSA id v24sm6152807pgi.91.2020.10.30.13.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 13:58:44 -0700 (PDT)
From:   Abhishek Kumar <kuabhs@chromium.org>
To:     johannes@sipsolutions.net
Cc:     ath10k@lists.infradead.org, briannorris@chromium.org,
        cjhuang@codeaurora.org, dianders@chromium.org,
        linux-wireless@vger.kernel.org, kuabhs@chromium.org
Subject: Re: [RFC 1/2] nl80211: add common API to configure SAR power limitations.
Date:   Fri, 30 Oct 2020 20:56:38 +0000
Message-Id: <20201030205639.1452712-1-kuabhs@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <6649b0c2ff988c2ae8723ea633f86cc12da43d95.camel@sipsolutions.net>
References: <6649b0c2ff988c2ae8723ea633f86cc12da43d95.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: kuabhs@chromium.org

These patches do not apply cleanly on kernel 5.4. I fixed the merged conflicts
and verified. I verified these APIs using power_manager in chromeos, the APIs 
works fine.
Tested-by: Abhishek Kumar <kuabhs@chromium.org>

-Abhishek
