Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95D01E88FB
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 14:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbfJ2NCA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 09:02:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39229 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfJ2NCA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 09:02:00 -0400
Received: from mail-yb1-f197.google.com ([209.85.219.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1iPR8I-0008Hp-4F
        for linux-wireless@vger.kernel.org; Tue, 29 Oct 2019 13:01:58 +0000
Received: by mail-yb1-f197.google.com with SMTP id 204so10461941yba.23
        for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2019 06:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FL85CBSOgXCnu82WdLvqv+Vd5YIBzEZye3EVxHX5wjE=;
        b=Cws59WnH3EfK+ewzne2mGQzgBkNucncTsnnh6Lf75LxXhvftZghOV7JU9qdKrBz0ZE
         UXtav7qn0C8gVGeYXyzp9201/21xBFMDaT6gq/QXx0VAf/LC0G75vbeEIMuXEgoW3P+x
         irEZJWqEILr87B8271bZjR9DSqj6UTklmAj8o6fLmVV35MsC1/eDEr7u+xmJwtWVByeu
         NhwWjC3EKWd13qw1bzsDRllOV46/FNuIn5FCKrhRph2VU242rIf9NAYfAcI5yDtvbeLD
         sAn8TwpxDZmy9e54gHreRhEW3rNPRFF4xi3+eVxFdmBfbgg7nDOqOAlpY1FPWTcCKLvK
         qZ/Q==
X-Gm-Message-State: APjAAAU6I3Jo4C3nmcqLOcgaA/351Ypw5CWnATM1yNtlfYmpxcGQbIvc
        9c8uPuRIq6vPOnzcndKabOQbrHgwjxWsoBpxq2+c9IlXmcUR8YcCSgwcyYF2R8s/ZqK18XlJUwq
        q+EWJviEBNdD4UTENtsirHAz/RnNHSQHTJFDSZdkC8wUJ
X-Received: by 2002:a81:7705:: with SMTP id s5mr16584325ywc.503.1572354117016;
        Tue, 29 Oct 2019 06:01:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyIp7VJsp8H2q6Snsz6l6u/oW/BJPUrXRJGUvA/7fVJs6UKEDdypgqy7lIFvqNR3tQt82G8Ig==
X-Received: by 2002:a81:7705:: with SMTP id s5mr16584277ywc.503.1572354116596;
        Tue, 29 Oct 2019 06:01:56 -0700 (PDT)
Received: from localhost ([2605:a601:ac3:9720:f461:b9b9:429:65bd])
        by smtp.gmail.com with ESMTPSA id j3sm10579724ywb.10.2019.10.29.06.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 06:01:55 -0700 (PDT)
Date:   Tue, 29 Oct 2019 08:01:54 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Emil Petersky <emil.petersky@streamunlimited.com>
Cc:     linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Subject: Re: [PATCH] wireless-regdb: Fix ranges of EU countries as they are
 harmonized since 2014...
Message-ID: <20191029130154.GL30813@ubuntu-xps13>
References: <bf327181-521b-e1ce-c5c8-81b828fc65b6@streamunlimited.com>
 <20190907235636.GA8256@ubuntu-xps13>
 <a5bdfce7-e974-37bb-c1d1-956d4572703c@streamunlimited.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5bdfce7-e974-37bb-c1d1-956d4572703c@streamunlimited.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Sep 17, 2019 at 09:58:27AM +0200, Emil Petersky wrote:
> Dear Seth,
> here you are, hopefully now it will work as it should.

Sorry for the delay. This patch is applied now, thanks!
