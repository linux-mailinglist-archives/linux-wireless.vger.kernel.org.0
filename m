Return-Path: <linux-wireless+bounces-18617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF797A2BF25
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 10:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C48407A3136
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 09:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5491D6182;
	Fri,  7 Feb 2025 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYo48zgh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D74B1A4F12;
	Fri,  7 Feb 2025 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920266; cv=none; b=OqzZs0dVKvLfKzQCXMC035qgjDZ/J5tnWvfi9oVxZxcFeXgyGEu0rQyie9DoKCtV6QkAB/JDfOQAs/KldCzchMxob4VSGlFz8L4flq8WsT9d+Gug2haSOyG/LuaFBcI4EvIV60xwSPATzT0gl9lkAKl7QKYKF/+LUiwSlwNunlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920266; c=relaxed/simple;
	bh=+MbzPOcGNRRPhnTBCFQgzSjGsnegZzFp3CefwijqsqA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=I9foAO8yU2aEN+FUnQQsRjdyoyHMla9ZsNbUarROOV8Jt7LFIWBFOJr4VQ2UeqlBXcgOv1BDkq65TEZdlrJWC3hiZwda+7LtzM+HKfb23mLVUy6A8dLfTm4JpMk4VXKWCYqQcIMcEqadGbZTiQDlXUqAx0uFojt/PeKB5oJqSy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYo48zgh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-436341f575fso21090125e9.1;
        Fri, 07 Feb 2025 01:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738920263; x=1739525063; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iKkuoAldlKbaq/b6Dxxu4R9211eD0SUopSgn5S6J0Yo=;
        b=DYo48zghdG1iOloiJ0+3d43U04Am7hVtTDLU8+gDQ2hTSHHD947mDCXtUFXgQd2tyE
         BHrhcBmG4IH7OyF4wgag3jg9G4kUgZfl/VKd1BQ7fphZQohvEILJ22VcGeflu1vXLoUC
         SFmgumpgyFHq52RUrsCqTVumXSmivQMR/9ClbGKxCph7KDw1cD+U3xttKOlpF/vRnb3R
         7O/JfrIxSiEHs9vKEKEcfxLgcHzHVRMYbxRGt9NwLLGeLcOYxG7Rc3nL5sjiJewX8JNx
         cRXRvKb1rtFDGXvJOalfEMopo9cTU4DRh1cYlpapswyoMgOGuaFLNizW0Id0f6G0dQEM
         bB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738920263; x=1739525063;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKkuoAldlKbaq/b6Dxxu4R9211eD0SUopSgn5S6J0Yo=;
        b=G4QvJhnoKPnrb+uHB06zyPtuEycfoVrQ2fWUWIDP25EviFVNR4B989jNhxxqobIYSJ
         zLZPTEbzAkyGNQC7n7o5bRpdQAxJAXEqS7n1WtxK/T2CvSk6hNCF0UUPQHVtV1uhKtS7
         ZnLUDvMT5LY+jzvOXFdpG9rmEO9jYaRcYJ5ox66s5IBD7IvPjjL4+Yv4LuG51F+HTJsE
         jNIMArlXcI8UvMVn9KlX64wut1jSdiwYnIlgZlvxMISWfveEPl6tElJWWzSYDIRDT4+L
         kL6AYg2dAR6q+6Ao1GFCCYzXtGrz3B9DUlmQMXKID3BMARD44/B5eVshNDj6plKDhsBh
         Q7Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWnP5eFkat60l3TnPHwW4AydROqFqig3yzZjTD++84kZv/YvMV6fZUbCcqnX5upOWjhpmRH/gAS9mpr+EBWVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYAkQM51WQS3qdq42UfP1CXL1YjF4dQaz8nPWuv+ciVSa8yKEE
	xjS9QTTsLC5qb3doQWtpse2d+qyM7lGywkEVmpmZ/cOlSmcHdGtYdLRnBA==
X-Gm-Gg: ASbGncuEjKtcuscJuqwwPzMjRv7nXCLZR/mz11lSxJa2V/pIdQF1VOu0FahWn3woUzF
	0o+buy4Zzj+/wJc8B7hJ9nsA3fjPQrf+3DaX3qK89HGbI1b7tPI76yhAKVguv/fBZ3bH2Ymxsyc
	W9MkM8bBp3aWuOwEGJsqraRl+Oei5WePerhnwWA1+/WQ1ooMbsj4HQu9SKrHskmhHzbUx8aABZy
	+H4Wkj0JiuQFbVxhb1BOC3GVudB0UAY2cmHGCOk7x4lGBCL+VUfodMI2FAt9VN/Wke6s3W1dsmZ
	RyC0FqjzzinrxkL4HMHzeh/mKcCB
X-Google-Smtp-Source: AGHT+IHhZnHjFwbkKjfbLgOfw31yp2iise56LxN7QfoigXsUv9a+uGxBG4cxjAvd8Vn74fQsjipemQ==
X-Received: by 2002:a05:600c:c0b:b0:436:1ac2:1acf with SMTP id 5b1f17b1804b1-439249a7c30mr21551365e9.20.1738920263262;
        Fri, 07 Feb 2025 01:24:23 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:14f1:dd0a:e74e:7c33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390daf44f3sm85554115e9.29.2025.02.07.01.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 01:24:22 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Johannes Berg <johannes@sipsolutions.net>,
  linux-wireless@vger.kernel.org,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 06/10] tools/net/ynl: sanitise enums with
 leading digits in ynl-gen-c
In-Reply-To: <20250206081033.49a7f4d6@kernel.org> (Jakub Kicinski's message of
	"Thu, 6 Feb 2025 08:10:33 -0800")
Date: Fri, 07 Feb 2025 09:24:14 +0000
Message-ID: <m2mseyxg3l.fsf@gmail.com>
References: <20250206092658.1383-1-donald.hunter@gmail.com>
	<20250206092658.1383-7-donald.hunter@gmail.com>
	<20250206081033.49a7f4d6@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu,  6 Feb 2025 09:26:54 +0000 Donald Hunter wrote:
>>  class Type(SpecAttr):
>> +    starts_with_digit = re.compile(r"^\d")
>> +
>>      def __init__(self, family, attr_set, attr, value):
>>          super().__init__(family, attr_set, attr, value)
>>  
>> @@ -74,6 +76,8 @@ class Type(SpecAttr):
>>          self.c_name = c_lower(self.name)
>>          if self.c_name in _C_KW:
>>              self.c_name += '_'
>> +        if self.starts_with_digit.match(self.c_name):
>> +            self.c_name = '_' + self.c_name
>
> bit heavyweight with the regex? I think this would do:
>
> 	if self.c_name[0].isdigit():

Agreed. I'll use the simpler method.

> but either way:
>
> Acked-by: Jakub Kicinski <kuba@kernel.org>

TY.

