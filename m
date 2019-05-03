Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0AD1289B
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 09:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbfECHTl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 03:19:41 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42123 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfECHTk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 03:19:40 -0400
Received: by mail-qk1-f196.google.com with SMTP id d4so218061qkc.9
        for <linux-wireless@vger.kernel.org>; Fri, 03 May 2019 00:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QM7AfUqv9k9zKnTHqiBijx2lB5XBzmJgjDSzIJSvgaw=;
        b=MLCXFbwWfEBOnWzPhKPriCy8m99/zPW868BxyTQr4D8AYeLqR6iAY+s+wdaHzTErN7
         FpdQHDdfOYHk+tiBeBh9oaehLhFKqyVcvYNCN9d026luHVVd9pOBoGcmhHaYfhmmCvWF
         yl4zqXNC8N3X25lUERnwdxELwPGRvKn5jEazE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QM7AfUqv9k9zKnTHqiBijx2lB5XBzmJgjDSzIJSvgaw=;
        b=BGBL7pX2/rP+ew3Na3L3B3JyBeNNxtEqnRIazpeh7btGR9nn4TNnnu0hEml8HWGbwO
         6bNuhKJZh5L3VVnkX6o3UJxQyEhiUl3FiYs9tEeCAOZK0zcOP5yXq3PB185UO/P7JOYn
         S03VeVM3nARv1p7myF7ifjraC2hRfV+r4wJZTtQW00tZu9b6XlCPfPf22oR4l8PQUwCJ
         Gr7sz8j98HPQp6xR5IUR82SWPvB/NGBy1xvGcBZMzbfIpswQwiiF/BKL71vjCGke8TWC
         xBBMr48dBpVpbg/iEnW4r0qoUVBLTbJTTl0tDeg6N8Z/YWeJvzvsl8UFTiUu9+UAGVSH
         q0Hw==
X-Gm-Message-State: APjAAAW52mZjNZ6SqCZnXaqAN9DBYjodbAIwGqkoGLbouA5U7AFfZK4J
        vkAR+HxDIEoqco77l+wxKmlavB6E2dc=
X-Google-Smtp-Source: APXvYqzE8J/oq7bmQ1witOLXpjnPDWo28/jw6NAN3mHYJmb27XK2LySHh8Q9Rl1EX8lURs6Bg9Irsw==
X-Received: by 2002:a37:6355:: with SMTP id x82mr6414034qkb.163.1556867979678;
        Fri, 03 May 2019 00:19:39 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id m46sm1136018qta.0.2019.05.03.00.19.38
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 00:19:38 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id i31so5586551qti.13
        for <linux-wireless@vger.kernel.org>; Fri, 03 May 2019 00:19:38 -0700 (PDT)
X-Received: by 2002:ac8:25a5:: with SMTP id e34mr7199582qte.346.1556867978193;
 Fri, 03 May 2019 00:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <1556536632-19433-1-git-send-email-wgong@codeaurora.org>
In-Reply-To: <1556536632-19433-1-git-send-email-wgong@codeaurora.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Fri, 3 May 2019 15:19:27 +0800
X-Gmail-Original-Message-ID: <CALiNf2-WUfiFeV5QDGRhjRh7A6J-y5xihN5M3RgBqdiiFKqAiw@mail.gmail.com>
Message-ID: <CALiNf2-WUfiFeV5QDGRhjRh7A6J-y5xihN5M3RgBqdiiFKqAiw@mail.gmail.com>
Subject: Re: [PATCH v2] ath10k: add peer id check in ath10k_peer_find_by_id
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Signed-off-by: Wen Gong <wgong@codeaurora.org>
Tested-by: Claire Chang <tientzu@chromium.org>
