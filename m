Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9FD1BE4C8
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2020 19:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgD2RIb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 13:08:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38409 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgD2RIa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 13:08:30 -0400
Received: from mail-qt1-f200.google.com ([209.85.160.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1jTqCC-0004j2-NN
        for linux-wireless@vger.kernel.org; Wed, 29 Apr 2020 17:08:28 +0000
Received: by mail-qt1-f200.google.com with SMTP id l26so3491895qtc.12
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2020 10:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g8rMWNZrnGHobFkc+0UpwyvpihpRy1NjP29Ky/0+zdw=;
        b=T18Fj5Nj13cdUC4pYt3xCaZ33OY9jPVocXg8I4ADdUTp16R0elEOLWpsaBXkhsiJX+
         HftXkDs3EV6eu892btrU6Tm+JZVKSe/kT3wGsrAlmMuwZHxYTGRsT8aUvQHkhr3onfGZ
         MqLiIxt2vKIRn9yd7wERe67Uu2Y1pO+T94hThwec1ZwsO14IXDglcVc0QFLaX6J17f9M
         lQDXCdb064yNLgByZ9vbacgIYCKHOGOt5kEKEBxmQdliPyT5H6J2LtXdNaSAsZJodoWg
         5eW1bwU3tlC2zJAvxSah1UXmZ+1JHMxx1xCdmiNAi/m1N6b8BD+N2YCVetJzCs038V0B
         yW0Q==
X-Gm-Message-State: AGi0PuZK2CZ9ccnm7J4JcBqbMaNMZopDH0LI+HqaQc+ue6mT6sT0kATi
        WdEfIu8aCMcElUFfQ3M3IOkzQC1nJPF+3wUdRdt0Tfq+c1qP/1j6RrNh6Pm1e4TLmhvp3dyMob4
        oDORakyahdtyp4uB/V53MT7YUoBuW5b4YbwVtgg8UyXOw
X-Received: by 2002:ac8:6d3b:: with SMTP id r27mr36750292qtu.55.1588180107837;
        Wed, 29 Apr 2020 10:08:27 -0700 (PDT)
X-Google-Smtp-Source: APiQypKGkd51PaWgnF5+t6KQjcNA6dAkZq93ULYaU+zWWcauQRzvI8jDXQbRruvfWZo+bXl1zCATRg==
X-Received: by 2002:ac8:6d3b:: with SMTP id r27mr36750244qtu.55.1588180107464;
        Wed, 29 Apr 2020 10:08:27 -0700 (PDT)
Received: from localhost ([2605:a601:af9b:a120:5455:5195:dbec:b612])
        by smtp.gmail.com with ESMTPSA id 130sm10922196qko.130.2020.04.29.10.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:08:26 -0700 (PDT)
Date:   Wed, 29 Apr 2020 12:08:25 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     chaitanya.mgit@gmail.com
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] [PATCH] GB: Extend to cover DMG channels 5 & 6
Message-ID: <20200429170825.GS3158@ubuntu-x1>
References: <20200326114506.943-1-chaitanya.mgit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326114506.943-1-chaitanya.mgit@gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Mar 26, 2020 at 05:15:06PM +0530, chaitanya.mgit@gmail.com wrote:
> From: Chaitanya Tata <chaitanya.mgit@gmail.com>
> 
> OFCOM extended the DMG band to include till 71GHz.
> 
> Signed-off-by: Chaitanya Tata <chaitanya.mgit@gmail.com>

Applied, thanks!
