Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7472617A444
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2020 12:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgCEL3t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Mar 2020 06:29:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37370 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725897AbgCEL3t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Mar 2020 06:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583407788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bWmZYuBqFe4P6NKv7YNOQnNI/DTRjEGt3iV2gL4Rqx0=;
        b=Li+6lDK9ddzEHnCVpulG+pr+rTJ9TfX+QtNda3COaLgFZ4xYeyU6pJXEAWV0YZkfKeJ06i
        mJewXL54DBb76rOO0fq4ceeH0LDQli7oRRLyiAL7E5TsgOYso17wiKLMFUkFxfWMBiQle7
        NP5zkAa3+cRdncH0FvGhkB2aNeIBJNI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-NuP4xlpXMVesm7ygN31waQ-1; Thu, 05 Mar 2020 06:29:47 -0500
X-MC-Unique: NuP4xlpXMVesm7ygN31waQ-1
Received: by mail-wm1-f69.google.com with SMTP id b23so1967058wmj.3
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2020 03:29:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bWmZYuBqFe4P6NKv7YNOQnNI/DTRjEGt3iV2gL4Rqx0=;
        b=jpC3zphfkSnAfZ/2mdPxyprg7yNDlHY4BZtcdqSCgOuv353/8Hxaglx6Q2e9in4GI6
         non5yXGBbwlmen6iKHq+8tzcaG7gopKPnBh5lHjiiwXytl8BJHRdoAqdd4VkD/drRzZ7
         90yUF+dS5C4qPCu3kFpmN0FSD6DQXsEZoVfKEzvZ288+uMPXF8MVipTIjx8uae/0ZV6i
         3kyfwtgXRb3qNGSYYtZ2kfD9rxMSC1GOYNDxPW5ARjgnWx2rbF2kkVPhguyqSjmBqOKs
         emMqvpt9NAmIzGwW8sAtCqm3Gsj30KHvPl4c4VO+Gx//KahOc3Dqplat0WdZUZva5vcs
         DLTw==
X-Gm-Message-State: ANhLgQ0DaurQVFeBf6F0UEXJZWFQB4lH90SMeHdqSNn/OMiLRhFLzP5e
        eW9SEG5Nknh5pQ+6K6G3QyZ9/OLzH5yoKkC/Hi5w3ndAIpyS+m5ffgfwTb24A4+dtt8qc4dV5tq
        PRFPRrNLGlRbeAh4yvxxJ4PAt1VY=
X-Received: by 2002:a05:600c:24d2:: with SMTP id 18mr9089743wmu.149.1583407785559;
        Thu, 05 Mar 2020 03:29:45 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtJKuEKZWiHcJZJ6a7d1lHkK1Ffk5FLY5/J6xDfuGQjlQkCrR8JkRKPoN1KVBQvGpu/KYmJkg==
X-Received: by 2002:a05:600c:24d2:: with SMTP id 18mr9089730wmu.149.1583407785392;
        Thu, 05 Mar 2020 03:29:45 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id z11sm8662608wmd.47.2020.03.05.03.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 03:29:44 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1214218034F; Thu,  5 Mar 2020 12:29:43 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Wei Liu <wei.liu1011@gmail.com>, linux-wireless@vger.kernel.org,
        linuxwifi@intel.com
Subject: Re: Precise time synchronization via wifi interface (intel AX201 iwlwifi driver)
In-Reply-To: <032f07e2-2771-619b-52b4-a25c8cd10f86@gmail.com>
References: <032f07e2-2771-619b-52b4-a25c8cd10f86@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 05 Mar 2020 12:29:43 +0100
Message-ID: <87r1y72g60.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wei Liu <wei.liu1011@gmail.com> writes:

> Hi,
>
> I am trying to achieve precise time synchronization via wifi
> interface.

Erm, good luck with that? :)

You do realise that there's a whole bunch of stuff going on below the
driver level (listen-before-send, etc) that makes 'precise' timing (as
in microsecond-accuracy like ptp)... shall we just say challenging?

-Toke

