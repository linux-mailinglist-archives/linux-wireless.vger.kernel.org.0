Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7481BE4C9
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2020 19:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgD2RIp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 13:08:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38420 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgD2RIp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 13:08:45 -0400
Received: from mail-qt1-f199.google.com ([209.85.160.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1jTqCR-0004kU-5R
        for linux-wireless@vger.kernel.org; Wed, 29 Apr 2020 17:08:43 +0000
Received: by mail-qt1-f199.google.com with SMTP id j21so3494432qtq.8
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2020 10:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tvwxznPeqyMlHfaQ0QnpPvOkX7EfJ/ddb92uXScn3WE=;
        b=pdaRrRl3PE+rgSMJKdFO0biBJH2I3TUgX9/0QAaQSjkca7QEFtL2ubZixAKQeC+hAu
         yHo/qTS/qbPEr8csV+DADaL7JG65l7Z98UxN8yiWlODpt6ect72FVl8qIgPSY5W5616V
         3cdFvIsdc/9q7LqjSzgn9xCKJPi/4nFumyeQk02rlNrWXtdRoSeaszK5tx3N2FxgIlLj
         8gJ8JNqjTWJ0I6moWlED+3FtzJhwY8VcPQsn989oC6++4XisiNEQLziTw9UmqFfBpOxO
         Du/i4ptUhYddx9q2kAjONu0ZNOkb89Nh/pzFdf6psm4xNZRru27MdXgNVonYHvGWbrXF
         Wu2w==
X-Gm-Message-State: AGi0Pua31CAwS+9/XFY9qQWY4F3OOJhB44fMXz78Tb4/KrB7IPJPMk7f
        f368QummbV1b/k5HMw7+q5Edy6jzViJrUQsXuv1FknqLL7Hdw8DHDuBmLlKTeX/8oZEWKZfsU4s
        O0dUEVg3yHoSoyNCxNZ5A8saD9/3miZhAcNL89e+gGskx
X-Received: by 2002:a37:64d2:: with SMTP id y201mr35171622qkb.370.1588180121897;
        Wed, 29 Apr 2020 10:08:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypIKqegoDfGU0AOZ1OALmLKoKzkatIfMZ8YHfIe/rRH1btEeU5B8ke+CDBj1KR9FEDxXX/DFSQ==
X-Received: by 2002:a37:64d2:: with SMTP id y201mr35171591qkb.370.1588180121613;
        Wed, 29 Apr 2020 10:08:41 -0700 (PDT)
Received: from localhost ([2605:a601:af9b:a120:5455:5195:dbec:b612])
        by smtp.gmail.com with ESMTPSA id 63sm15698221qkl.64.2020.04.29.10.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:08:41 -0700 (PDT)
Date:   Wed, 29 Apr 2020 12:08:40 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     bkil <b.K.il.h.u+tigbuh@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless-regdb: update rules for US on 2.4/5G
Message-ID: <20200429170840.GT3158@ubuntu-x1>
References: <bd3095568bfcb9ee543cc1b2b68d22f5cd6e1c3c.1586117381.git.b.K.il.h.u+tigbuh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd3095568bfcb9ee543cc1b2b68d22f5cd6e1c3c.1586117381.git.b.K.il.h.u+tigbuh@gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Apr 05, 2020 at 10:09:42PM +0200, bkil wrote:
> The bands are wider and more continuous:
> 5.15-5.35 GHz, 5.47-5.725 GHz and 5.725-5.85 GHz.
> Based on the April 2, 2020 version of e-CFR Title 47 Part 15,
> Radio Frequency Devices.
> 
> This also includes a small tweak for channel 144 similar to TW.
> 
> Signed-off-by: bkil <b.K.il.h.u+tigbuh@gmail.com>

Applied, thanks!
